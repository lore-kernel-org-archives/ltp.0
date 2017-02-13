From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 17:20:40 +0100
Subject: [LTP] [PATCH 4/6] test.sh: Remove tst_{acquire, release}_device,
	tst_mkfs
In-Reply-To: <1615801703.3823999.1487001835110.JavaMail.zimbra@redhat.com>
References: <20170208110255.443-1-chrubis@suse.cz>
 <20170208110255.443-4-chrubis@suse.cz>
 <1615801703.3823999.1487001835110.JavaMail.zimbra@redhat.com>
Message-ID: <20170213162039.GA10093@rei.lan>
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

Ah, missed that one. So tst_mkfs() has to stay in test.sh.

> Other than that, I think we agreed to drop/replace 1/6, and skip
> update_results() if ipc has not been set up.

I have that change in my my tree already.

> The rest looks good to me.

Ok.

-- 
Cyril Hrubis
chrubis@suse.cz
