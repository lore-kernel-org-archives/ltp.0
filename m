From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Aug 2019 11:45:50 +0200
Subject: [LTP] MIPS/MIPS64 syscalls
In-Reply-To: <2c982dfd-9929-8969-4c4e-18d2d91ede1b@windriver.com>
References: <2c982dfd-9929-8969-4c4e-18d2d91ede1b@windriver.com>
Message-ID: <20190820094550.GA19308@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There seems not any mips/mips64 syscalls defined. Where can we find
> them? or do we support them?

You need to create these files based on the numbers defined in kernel
syscall tables, look at arch/mips/kernel/syscalls/*.tbl, then you need
to add newly added architectures into the order file so that the headers
are generated correctly.

Also it looks like there are two 32bit ABIs there though not sure if we
need to support both in LTP though.

-- 
Cyril Hrubis
chrubis@suse.cz
