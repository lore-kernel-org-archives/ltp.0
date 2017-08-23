From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Aug 2017 16:18:00 +0200
Subject: [LTP] [PATCH 2/2] syscalls/keyctl: Make use of lapi/keyctl.h &&
 Add existing test to runtest/cve
In-Reply-To: <20170823110032.1795-2-fenggw-fnst@cn.fujitsu.com>
References: <20170823110032.1795-1-fenggw-fnst@cn.fujitsu.com>
 <20170823110032.1795-2-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170823141800.GC20766@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	keyctl(KEYCTL_READ, key, buffer, 4);
> +	tst_syscall(__NR_keyctl, KEYCTL_READ, key, buffer, 4);

What about we, instead of using raw syscall, defined fallback keyctl()
and add_key() in the lapi/keyctl.h that would call the syscall? That way
we would test the keyutils library if present but these tests will not
be disabled otherwise.

-- 
Cyril Hrubis
chrubis@suse.cz
