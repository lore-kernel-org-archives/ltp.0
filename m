From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 16:52:56 +0200
Subject: [LTP] [PATCH] Test for CVE-2016-7042 in /proc/keys show function
In-Reply-To: <87lgnd9bxh.fsf@our.domain.is.not.set>
References: <20170725060341.14752-1-fenggw-fnst@cn.fujitsu.com>
 <87lgnd9bxh.fsf@our.domain.is.not.set>
Message-ID: <20170818145256.GF22319@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've created the lapi header meanwhile and so we can make use of it here
but moreover, shouldn't we put this one into the syscalls/keyctl/
directory as we did with previous test and add only runtest CVE entry?

I guess that it makes sense to put syscall tests to syscalls/foo/
directories in a case that we can clearly say that the bug was present
in a particual syscall...

-- 
Cyril Hrubis
chrubis@suse.cz
