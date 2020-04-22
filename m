From: Filip Bozuta <fbozuta1@gmail.com>
Date: Wed, 22 Apr 2020 17:28:38 +0200
Subject: [LTP] [PATCH 0/3] Add tests for a group of real time clock ioctls
Message-ID: <20200422152841.13432-1-fbozuta1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This series covers tests for following RTC ioctls:

    *RTC_RD_TIME    *RTC_UIE_ON
    *RTC_SET_TIME   *RTC_UIE_OFF
    *RTC_ALM_READ   *RTC_PIE_ON
    *RTC_ALM_SET    *RTC_PIE_OFF
    *RTC_AIE_ON     *RTC_WIE_ON
    *RTC_AIE_OFF    *RTC_WIE_OFF

The functionalities of individual ioctls were described in this series
patch commit messages.

The testing method for these ioctls is described in the upper comment
sections of test programs.

Filip Bozuta (3):
  testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to read
    and set RTC time
  testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to read
    and set RTC alarm time
  testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to turn
    on/off RTC interrupts

 runtest/syscalls                              |   4 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   3 +
 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c | 112 ++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_rtc02.c | 107 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c |  88 ++++++++++++++
 5 files changed, 314 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc02.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c

-- 
2.17.1
