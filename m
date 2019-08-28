From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Aug 2019 14:23:21 +0200
Subject: [LTP] [PATCH] syscalls: rt_sigwaitinfo01: Fix failure for MIPS
 arches
In-Reply-To: <4200333.8516580.1566933979370.JavaMail.zimbra@redhat.com>
References: <1566544121-147769-1-git-send-email-zhe.he@windriver.com>
 <4200333.8516580.1566933979370.JavaMail.zimbra@redhat.com>
Message-ID: <20190828122321.GD32066@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So I'm wondering if need to have an absolute value here, and if we can't
> replace it with sizeof(sigset_t) or _NSIG / 8?

+1

-- 
Cyril Hrubis
chrubis@suse.cz
