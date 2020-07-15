From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2020 11:00:15 +0200
Subject: [LTP] [PATCH] tst_timer: pass kernel_timer_t type to syscalls
In-Reply-To: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
References: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
Message-ID: <20200715090015.GB7741@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> timer_[gs]etttime tests are failing on s390, which is big endian
> system, because tests are passing timer_t type, which is glibc
> type (void *). Kernel expects and sets only int portion, so the
> tests fail for all but first (0) timer id.

Looks good to me:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
