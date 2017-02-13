From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 17:39:33 +0100
Subject: [LTP] [PATCH 4/6] test.sh: Remove tst_{acquire, release}_device,
	tst_mkfs
In-Reply-To: <1615801703.3823999.1487001835110.JavaMail.zimbra@redhat.com>
References: <20170208110255.443-1-chrubis@suse.cz>
 <20170208110255.443-4-chrubis@suse.cz>
 <1615801703.3823999.1487001835110.JavaMail.zimbra@redhat.com>
Message-ID: <20170213163933.GB10093@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > There are not used by any test that uses test.sh library.
> 
> Not even this one? ./testcases/kernel/fs/fs_readonly/test_robind.sh
> It sources test.sh and calls tst_mkfs.

I've readded the tst_mkfs() to that patch but forget to update the
commit message, sorry. (that is what you get for pushing patches at the
end of the day)

Anyway, the patchset is pushed, I will continue to work on the safe
macros in cleanup tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz
