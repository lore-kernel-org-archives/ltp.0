From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Apr 2020 18:11:51 +0800
Subject: [LTP] [PATCH] ltp_tpci.c: fix a null pointer
In-Reply-To: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1584507302-23515-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5E870BE7.9070809@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/18 12:55, Yang Xu wrote:
> ps: I want to use a dymaic domain to fix it but failed. If someone know,
> please tell me. Also, this case failed when merging this patch because
> test 13 (test_assign_resources) report no space error as below:
> [754930.757585] ltp_tpci: test-case 13
> [754930.757585] ltp_tpci: assign resources
> [754930.757585] ltp_tpci: assign resource #0
> [754930.757586] ltp_tpci: name = 0000:00:08.0, flags = 262401, start 0xc140, end 0xc17f
> [754930.757586] ltp_tpci: assign resource #1
> [754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 262656, start 0xfebd7000, end 0xfebd7fff
> [754930.757587] ltp_tpci: assign resource #2
> [754930.757587] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
> [754930.757588] ltp_tpci: assign resource #3
> [754930.757588] ltp_tpci: name = 0000:00:08.0, flags = 0, start 0x0, end 0x0
> [754930.757588] ltp_tpci: assign resource #4
> [754930.757589] ltp_tpci: name = 0000:00:08.0, flags = 538190348, start 0xfe80c000, end 0xfe80ffff
> [754930.757593] virtio-pci 0000:00:08.0: BAR 4: no space for [mem size 0x00004000 64bit pref]
> [754930.757594] virtio-pci 0000:00:08.0: BAR 4: failed to assign [mem size 0x00004000 64bit pref
>
Hi Xu,

Do you mean that the fix patch results in the failure of subtest 13?
If so, we may need a better solution.

Thanks,
Xiao Yang


