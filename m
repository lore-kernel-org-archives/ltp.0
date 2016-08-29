From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Aug 2016 17:17:52 +0200
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <57C440C0.5050307@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160829125050.GD30021@rei.lan> <57C43307.8000709@oracle.com>
 <8140813.24444.1472477694219.JavaMail.zimbra@redhat.com>
 <57C43FEF.50402@oracle.com> <57C440C0.5050307@oracle.com>
Message-ID: <20160829151752.GA1816@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking into the kernel/module.c the /proc/modules is implemented with
seq_* operations and the list of modules is iterated one by one util
there is a space in buffer. And it looks like the module_mutex is
acquired and released each time we call read(), so there is a chance
that we race against something that loads/unloads kernel modules between
the reads we do. Which would explain why we hit this only under certain
conditions...

But I still do not see how writing to NFS triggers module load/unload or
module refcount increment/decrement. I guess that this would be very
hard to figure out without somebody who is familiar with the nfs code.

-- 
Cyril Hrubis
chrubis@suse.cz
