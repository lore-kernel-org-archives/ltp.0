From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 13:02:45 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <20170208111055.GA16139@rei.lan>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
 <20170202152242.GA11304@rei.lan> <20170208111055.GA16139@rei.lan>
Message-ID: <20170209120245.GD12673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There is still one unsolved problem since the TWARN messages from the
> tst_device.c will trigger TBROK in tst_test.c since the IPC is not
> initialized. I'm still unsure how to fix that, maybe we should allow to
> allocate non-shared structure for the results in the special case that
> the library code is being reused in shell helpers.

Maybe we should just add an API to redirect tst_brk() and tst_res() so
that we could use library code in the various non-test utilities. Maybe
we could patch things up so that we could use SAFE_MACROS() in cleanup
as well...

-- 
Cyril Hrubis
chrubis@suse.cz
