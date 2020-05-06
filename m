From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 May 2020 17:56:16 +0200
Subject: [LTP] [PATCH 1/1] pty04: Fix build for kernel headers < v4.2-rc1
In-Reply-To: <20200506154724.GA19535@dell5510>
References: <20200506134858.23919-1-pvorel@suse.cz>
 <20200506154724.GA19535@dell5510>
Message-ID: <20200506155616.GE11352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The struct added in 6b6b56cf3 ("pty04: Add SLCAN ldisc and check for CVE-2020-11494") uses
> uint32_t, kernel version always used __u8. Richie, any reason to use uint32_t
> instead of uint8_t? I does not fixes the problem, I'm just asking, whether
> different size affect test coverage.
> 
> struct can_frame {
> 	canid_t can_id;
> 	uint32_t can_dlc;
> 	uint32_t __pad;
> 	uint32_t __res0;
> 	uint32_t __res1;
> 	uint32_t data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> };
> 
> struct can_frame {
> 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> 	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
> 	__u8    __pad;   /* padding */
> 	__u8    __res0;  /* reserved / padding */
> 	__u8    __res1;  /* reserved / padding */
> 	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> };

These two structures are for sure incompatible, that should be uint8_t
instead uint32_t.

-- 
Cyril Hrubis
chrubis@suse.cz
