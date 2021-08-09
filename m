From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 11:53:05 +0200
Subject: [LTP] [PATCH v2 01/16] lib/tst_sched: add ltp
 sys/libc_sched_*() wrappers
In-Reply-To: <20210806164730.51040-2-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-2-aleksei.kodanev@bell-sw.com>
Message-ID: <YRD7Aab7Od6gZ1Rh@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _TST_LIBC_SCHED_SCALL(SCALL, ...)({ \

Please do not add any identifiers that start with underscore, these are
reserved for OS implementation e.g. libc and kernel headers.

We usually add the underscore to the end instead, so this will end up as

#define TST_LIBC_SCHED_SCALL_(SCALL, ...) ...

-- 
Cyril Hrubis
chrubis@suse.cz
