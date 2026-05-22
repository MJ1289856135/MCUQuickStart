  .syntax unified
  .cpu cortex-m4
  .thumb

.global  Default_Handler

/* necessary symbols defined in linker script to initialize data */
.word  _sidata
.word  _sdata
.word  _edata
.word  _sbss
.word  _ebss

  .section  .text.Reset_Handler
  .weak  Reset_Handler
  .type  Reset_Handler, %function

/* reset Handler */
Reset_Handler:
  ldr sp, =_sp          /* 鏄惧紡璁剧疆涓绘爤鎸囬拡 */
  movs r1, #0
  b DataInit

CopyData:
  ldr r3, =_sidata
  ldr r3, [r3, r1]
  str r3, [r0, r1]
  adds r1, r1, #4

DataInit:
  ldr r0, =_sdata
  ldr r3, =_edata
  adds r2, r0, r1
  cmp r2, r3
  bcc CopyData
  ldr r2, =_sbss
  b Zerobss

FillZerobss:
  movs r3, #0
  str r3, [r2], #4

Zerobss:
  ldr r3, = _ebss
  cmp r2, r3
  bcc FillZerobss
/* Call SystemInit function */
  bl  SystemInit
/* Call static constructors */
  bl __libc_init_array
/*Call the main function */
  bl main
  bx lr
.size Reset_Handler, .-Reset_Handler

    .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b Infinite_Loop
  .size Default_Handler, .-Default_Handler

   .section  .vectors,"a",%progbits
   .global __gVectors

__gVectors:
                    .word WWDGT_IRQHandler
                    .word LVD_IRQHandler
                    .word TAMPER_STAMP_IRQHandler
                    .word RTC_WKUP_IRQHandler
                    .word FMC_IRQHandler
                    .word RCU_CTC_IRQHandler
                    .word EXTI0_IRQHandler
                    .word EXTI1_IRQHandler
                    .word EXTI2_IRQHandler
                    .word EXTI3_IRQHandler
                    .word EXTI4_IRQHandler
                    .word DMA0_Channel0_IRQHandler
                    .word DMA0_Channel1_IRQHandler
                    .word DMA0_Channel2_IRQHandler
                    .word DMA0_Channel3_IRQHandler
                    .word DMA0_Channel4_IRQHandler
                    .word DMA0_Channel5_IRQHandler
                    .word DMA0_Channel6_IRQHandler
                    .word ADC_IRQHandler
                    .word CAN0_TX_IRQHandler
                    .word CAN0_RX0_IRQHandler
                    .word CAN0_RX1_IRQHandler
                    .word CAN0_EWMC_IRQHandler
                    .word EXTI5_9_IRQHandler
                    .word TIMER0_BRK_TIMER8_IRQHandler
                    .word TIMER0_UP_TIMER9_IRQHandler
                    .word TIMER0_TRG_CMT_TIMER10_IRQHandler
                    .word TIMER0_Channel_IRQHandler
                    .word TIMER1_IRQHandler
                    .word TIMER2_IRQHandler
                    .word TIMER3_IRQHandler
                    .word I2C0_EV_IRQHandler
                    .word I2C0_ER_IRQHandler
                    .word I2C1_EV_IRQHandler
                    .word I2C1_ER_IRQHandler
                    .word SPI0_IRQHandler
                    .word SPI1_IRQHandler
                    .word USART0_IRQHandler
                    .word USART1_IRQHandler
                    .word USART2_IRQHandler
                    .word EXTI10_15_IRQHandler
                    .word RTC_Alarm_IRQHandler
                    .word USBFS_WKUP_IRQHandler
                    .word TIMER7_BRK_TIMER11_IRQHandler
                    .word TIMER7_UP_TIMER12_IRQHandler
                    .word TIMER7_TRG_CMT_TIMER13_IRQHandler
                    .word TIMER7_Channel_IRQHandler
                    .word DMA0_Channel7_IRQHandler
                    .word EXMC_IRQHandler
                    .word SDIO_IRQHandler
                    .word TIMER4_IRQHandler
                    .word SPI2_IRQHandler
                    .word UART3_IRQHandler
                    .word UART4_IRQHandler
                    .word TIMER5_DAC_IRQHandler
                    .word TIMER6_IRQHandler
                    .word DMA1_Channel0_IRQHandler
                    .word DMA1_Channel1_IRQHandler
                    .word DMA1_Channel2_IRQHandler
                    .word DMA1_Channel3_IRQHandler
                    .word DMA1_Channel4_IRQHandler
                    .word ENET_IRQHandler
                    .word ENET_WKUP_IRQHandler
                    .word CAN1_TX_IRQHandler
                    .word CAN1_RX0_IRQHandler
                    .word CAN1_RX1_IRQHandler
                    .word CAN1_EWMC_IRQHandler
                    .word USBFS_IRQHandler
                    .word DMA1_Channel5_IRQHandler
                    .word DMA1_Channel6_IRQHandler
                    .word DMA1_Channel7_IRQHandler
                    .word USART5_IRQHandler
                    .word I2C2_EV_IRQHandler
                    .word I2C2_ER_IRQHandler
                    .word USBHS_EP1_Out_IRQHandler
                    .word USBHS_EP1_In_IRQHandler
                    .word USBHS_WKUP_IRQHandler
                    .word USBHS_IRQHandler
                    .word DCI_IRQHandler
                    .word 0                                       /* Reserved
                    .word TRNG_IRQHandler
                    .word FPU_IRQHandler
  .size   __gVectors, . - __gVectors

  .weak NMI_Handler
  .thumb_set NMI_Handler,Default_Handler

  .weak HardFault_Handler
  .thumb_set HardFault_Handler,Default_Handler

  .weak MemManage_Handler
  .thumb_set MemManage_Handler,Default_Handler

  .weak BusFault_Handler
  .thumb_set BusFault_Handler,Default_Handler

  .weak UsageFault_Handler
  .thumb_set UsageFault_Handler,Default_Handler

  .weak SVC_Handler
  .thumb_set SVC_Handler,Default_Handler

  .weak DebugMon_Handler
  .thumb_set DebugMon_Handler,Default_Handler

  .weak PendSV_Handler
  .thumb_set PendSV_Handler,Default_Handler

  .weak SysTick_Handler
  .thumb_set SysTick_Handler,Default_Handler

  .
  .weak WWDGT_IRQHandler
  .thumb_set WWDGT_IRQHandler,Default_Handler
  .weak LVD_IRQHandler
  .thumb_set LVD_IRQHandler,Default_Handler
  .weak TAMPER_STAMP_IRQHandler
  .thumb_set TAMPER_STAMP_IRQHandler,Default_Handler
  .weak RTC_WKUP_IRQHandler
  .thumb_set RTC_WKUP_IRQHandler,Default_Handler
  .weak FMC_IRQHandler
  .thumb_set FMC_IRQHandler,Default_Handler
  .weak RCU_CTC_IRQHandler
  .thumb_set RCU_CTC_IRQHandler,Default_Handler
  .weak EXTI0_IRQHandler
  .thumb_set EXTI0_IRQHandler,Default_Handler
  .weak EXTI1_IRQHandler
  .thumb_set EXTI1_IRQHandler,Default_Handler
  .weak EXTI2_IRQHandler
  .thumb_set EXTI2_IRQHandler,Default_Handler
  .weak EXTI3_IRQHandler
  .thumb_set EXTI3_IRQHandler,Default_Handler
  .weak EXTI4_IRQHandler
  .thumb_set EXTI4_IRQHandler,Default_Handler
  .weak DMA0_Channel0_IRQHandler
  .thumb_set DMA0_Channel0_IRQHandler,Default_Handler
  .weak DMA0_Channel1_IRQHandler
  .thumb_set DMA0_Channel1_IRQHandler,Default_Handler
  .weak DMA0_Channel2_IRQHandler
  .thumb_set DMA0_Channel2_IRQHandler,Default_Handler
  .weak DMA0_Channel3_IRQHandler
  .thumb_set DMA0_Channel3_IRQHandler,Default_Handler
  .weak DMA0_Channel4_IRQHandler
  .thumb_set DMA0_Channel4_IRQHandler,Default_Handler
  .weak DMA0_Channel5_IRQHandler
  .thumb_set DMA0_Channel5_IRQHandler,Default_Handler
  .weak DMA0_Channel6_IRQHandler
  .thumb_set DMA0_Channel6_IRQHandler,Default_Handler
  .weak ADC_IRQHandler
  .thumb_set ADC_IRQHandler,Default_Handler
  .weak CAN0_TX_IRQHandler
  .thumb_set CAN0_TX_IRQHandler,Default_Handler
  .weak CAN0_RX0_IRQHandler
  .thumb_set CAN0_RX0_IRQHandler,Default_Handler
  .weak CAN0_RX1_IRQHandler
  .thumb_set CAN0_RX1_IRQHandler,Default_Handler
  .weak CAN0_EWMC_IRQHandler
  .thumb_set CAN0_EWMC_IRQHandler,Default_Handler
  .weak EXTI5_9_IRQHandler
  .thumb_set EXTI5_9_IRQHandler,Default_Handler
  .weak TIMER0_BRK_TIMER8_IRQHandler
  .thumb_set TIMER0_BRK_TIMER8_IRQHandler,Default_Handler
  .weak TIMER0_UP_TIMER9_IRQHandler
  .thumb_set TIMER0_UP_TIMER9_IRQHandler,Default_Handler
  .weak TIMER0_TRG_CMT_TIMER10_IRQHandler
  .thumb_set TIMER0_TRG_CMT_TIMER10_IRQHandler,Default_Handler
  .weak TIMER0_Channel_IRQHandler
  .thumb_set TIMER0_Channel_IRQHandler,Default_Handler
  .weak TIMER1_IRQHandler
  .thumb_set TIMER1_IRQHandler,Default_Handler
  .weak TIMER2_IRQHandler
  .thumb_set TIMER2_IRQHandler,Default_Handler
  .weak TIMER3_IRQHandler
  .thumb_set TIMER3_IRQHandler,Default_Handler
  .weak I2C0_EV_IRQHandler
  .thumb_set I2C0_EV_IRQHandler,Default_Handler
  .weak I2C0_ER_IRQHandler
  .thumb_set I2C0_ER_IRQHandler,Default_Handler
  .weak I2C1_EV_IRQHandler
  .thumb_set I2C1_EV_IRQHandler,Default_Handler
  .weak I2C1_ER_IRQHandler
  .thumb_set I2C1_ER_IRQHandler,Default_Handler
  .weak SPI0_IRQHandler
  .thumb_set SPI0_IRQHandler,Default_Handler
  .weak SPI1_IRQHandler
  .thumb_set SPI1_IRQHandler,Default_Handler
  .weak USART0_IRQHandler
  .thumb_set USART0_IRQHandler,Default_Handler
  .weak USART1_IRQHandler
  .thumb_set USART1_IRQHandler,Default_Handler
  .weak USART2_IRQHandler
  .thumb_set USART2_IRQHandler,Default_Handler
  .weak EXTI10_15_IRQHandler
  .thumb_set EXTI10_15_IRQHandler,Default_Handler
  .weak RTC_Alarm_IRQHandler
  .thumb_set RTC_Alarm_IRQHandler,Default_Handler
  .weak USBFS_WKUP_IRQHandler
  .thumb_set USBFS_WKUP_IRQHandler,Default_Handler
  .weak TIMER7_BRK_TIMER11_IRQHandler
  .thumb_set TIMER7_BRK_TIMER11_IRQHandler,Default_Handler
  .weak TIMER7_UP_TIMER12_IRQHandler
  .thumb_set TIMER7_UP_TIMER12_IRQHandler,Default_Handler
  .weak TIMER7_TRG_CMT_TIMER13_IRQHandler
  .thumb_set TIMER7_TRG_CMT_TIMER13_IRQHandler,Default_Handler
  .weak TIMER7_Channel_IRQHandler
  .thumb_set TIMER7_Channel_IRQHandler,Default_Handler
  .weak DMA0_Channel7_IRQHandler
  .thumb_set DMA0_Channel7_IRQHandler,Default_Handler
  .weak EXMC_IRQHandler
  .thumb_set EXMC_IRQHandler,Default_Handler
  .weak SDIO_IRQHandler
  .thumb_set SDIO_IRQHandler,Default_Handler
  .weak TIMER4_IRQHandler
  .thumb_set TIMER4_IRQHandler,Default_Handler
  .weak SPI2_IRQHandler
  .thumb_set SPI2_IRQHandler,Default_Handler
  .weak UART3_IRQHandler
  .thumb_set UART3_IRQHandler,Default_Handler
  .weak UART4_IRQHandler
  .thumb_set UART4_IRQHandler,Default_Handler
  .weak TIMER5_DAC_IRQHandler
  .thumb_set TIMER5_DAC_IRQHandler,Default_Handler
  .weak TIMER6_IRQHandler
  .thumb_set TIMER6_IRQHandler,Default_Handler
  .weak DMA1_Channel0_IRQHandler
  .thumb_set DMA1_Channel0_IRQHandler,Default_Handler
  .weak DMA1_Channel1_IRQHandler
  .thumb_set DMA1_Channel1_IRQHandler,Default_Handler
  .weak DMA1_Channel2_IRQHandler
  .thumb_set DMA1_Channel2_IRQHandler,Default_Handler
  .weak DMA1_Channel3_IRQHandler
  .thumb_set DMA1_Channel3_IRQHandler,Default_Handler
  .weak DMA1_Channel4_IRQHandler
  .thumb_set DMA1_Channel4_IRQHandler,Default_Handler
  .weak ENET_IRQHandler
  .thumb_set ENET_IRQHandler,Default_Handler
  .weak ENET_WKUP_IRQHandler
  .thumb_set ENET_WKUP_IRQHandler,Default_Handler
  .weak CAN1_TX_IRQHandler
  .thumb_set CAN1_TX_IRQHandler,Default_Handler
  .weak CAN1_RX0_IRQHandler
  .thumb_set CAN1_RX0_IRQHandler,Default_Handler
  .weak CAN1_RX1_IRQHandler
  .thumb_set CAN1_RX1_IRQHandler,Default_Handler
  .weak CAN1_EWMC_IRQHandler
  .thumb_set CAN1_EWMC_IRQHandler,Default_Handler
  .weak USBFS_IRQHandler
  .thumb_set USBFS_IRQHandler,Default_Handler
  .weak DMA1_Channel5_IRQHandler
  .thumb_set DMA1_Channel5_IRQHandler,Default_Handler
  .weak DMA1_Channel6_IRQHandler
  .thumb_set DMA1_Channel6_IRQHandler,Default_Handler
  .weak DMA1_Channel7_IRQHandler
  .thumb_set DMA1_Channel7_IRQHandler,Default_Handler
  .weak USART5_IRQHandler
  .thumb_set USART5_IRQHandler,Default_Handler
  .weak I2C2_EV_IRQHandler
  .thumb_set I2C2_EV_IRQHandler,Default_Handler
  .weak I2C2_ER_IRQHandler
  .thumb_set I2C2_ER_IRQHandler,Default_Handler
  .weak USBHS_EP1_Out_IRQHandler
  .thumb_set USBHS_EP1_Out_IRQHandler,Default_Handler
  .weak USBHS_EP1_In_IRQHandler
  .thumb_set USBHS_EP1_In_IRQHandler,Default_Handler
  .weak USBHS_WKUP_IRQHandler
  .thumb_set USBHS_WKUP_IRQHandler,Default_Handler
  .weak USBHS_IRQHandler
  .thumb_set USBHS_IRQHandler,Default_Handler
  .weak DCI_IRQHandler
  .thumb_set DCI_IRQHandler,Default_Handler
  .weak TRNG_IRQHandler
  .thumb_set TRNG_IRQHandler,Default_Handler
  .weak FPU_IRQHandler
  .thumb_set FPU_IRQHandler,Default_Handler
