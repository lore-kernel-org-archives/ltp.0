From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Jun 2021 15:30:26 +0200
Subject: [LTP] [PATCH v5] adjtimex02.c: Skipped EFAULT tests for libc
 variant
In-Reply-To: <20210613161941.4934-1-vinay.m.engg@gmail.com>
References: <YMNNHVaIQZ84+lLS@yuki>
 <20210613161941.4934-1-vinay.m.engg@gmail.com>
Message-ID: <YMdZ8pKCr6DhFZcQ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with changes, thanks.

* Removed a few useless whitespace changes

* Added back the kernel version check, without that there would be no
  point in keeping the ADJ_OFFSET tests, and maybe these should have
  been removed now since 2.6.26 is prehistoric

* Added docparse formatted comment

* Changed the buf->modes to use the tc[i].modes instead of SET_MODES

-- 
Cyril Hrubis
chrubis@suse.cz
