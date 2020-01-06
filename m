From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jan 2020 16:03:29 +0100
Subject: [LTP] LTP Release plans
In-Reply-To: <20191213125435.GB20795@rei.lan>
References: <20191213125435.GB20795@rei.lan>
Message-ID: <20200106150329.GC26880@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all Happy New Year!

I'm back at patch review and we are getting close to a pre-release
testing freeze.

As I stated before I will have a look at he fallocate05 test and the
capset/capget patches. Is there anything else that should be part of the
release?

Looking at the patch queue we should probably include:

tst_dev_bytes_written: parsing /proc/diskstats instead of sys file
syscalls/userfaultfd01: add hint about unprivileged_userfaultfd

Anything else I should look at?

-- 
Cyril Hrubis
chrubis@suse.cz
