From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 16:54:58 +0200
Subject: [LTP] [PATCH] Test for CVE-2016-7042 in /proc/keys show function
In-Reply-To: <20170818145256.GF22319@rei.lan>
References: <20170725060341.14752-1-fenggw-fnst@cn.fujitsu.com>
 <87lgnd9bxh.fsf@our.domain.is.not.set>
 <20170818145256.GF22319@rei.lan>
Message-ID: <20170818145458.GG22319@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I guess that it makes sense to put syscall tests to syscalls/foo/
> directories in a case that we can clearly say that the bug was present
> in a particual syscall...

Looking at the test close the bug has been in the proc handler, so we
may as well put it into the CVE directory.

-- 
Cyril Hrubis
chrubis@suse.cz
