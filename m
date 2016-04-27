From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Apr 2016 14:02:41 +0200
Subject: [LTP] [RFC] [PATCH] lib/tst_mkfs: Exit with TCONF on missing
 mkfs.foo
In-Reply-To: <2047893553.473657.1461687813294.JavaMail.zimbra@redhat.com>
References: <20160426110035.GA6780@rei.lan>
 <781652551.335143.1461671230875.JavaMail.zimbra@redhat.com>
 <20160426122824.GB6766@rei.lan>
 <2047893553.473657.1461687813294.JavaMail.zimbra@redhat.com>
Message-ID: <20160427120241.GA17331@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Maybe we can exit with 255 on ENOENT and with 254 otherwise.
> 
> Fine by me, I just wanted to avoid hiding every error under TCONF.

I've pushed this change for tst_run_cmd in separate patch, then the
patch for tst_mkfs.

-- 
Cyril Hrubis
chrubis@suse.cz
