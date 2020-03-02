From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Mar 2020 08:31:21 +0100
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
Message-ID: <20200302073121.GA18621@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> I am getting a build warning now (same happen if I build bpf stuff as
> well). I don't understand why this warning comes though.

> openat202.c:69:1: warning: missing initializer for field 'caps' of 'struct tst_test' [-Wmissing-field-initializers]
>  };
>  ^
> In file included from openat202.c:7:0:
> ../../../../include/tst_test.h:236:18: note: 'caps' declared here
>   struct tst_cap *caps;
>                   ^~~~

This is false positive warning. Unfortunately we don't know how to avoid it.

Kind regards,
Petr
