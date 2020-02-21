From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Feb 2020 15:16:56 +0100
Subject: [LTP] [PATCH v2 1/2] syscalls/fcntl30: clean up && add more
 range test
In-Reply-To: <6c3adcfb-b3e4-ba8f-d084-a664145c1380@cn.fujitsu.com>
References: <1579686442-24689-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200127162016.GD30831@rei.lan>
 <6c3adcfb-b3e4-ba8f-d084-a664145c1380@cn.fujitsu.com>
Message-ID: <20200221141656.GA18564@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Do we really need this? Looking at the kernel code the fcntl() just
> > reallocates the array that is holding the slots, so we only allocate new
> > array of struct pipe_buffer which contains a pointer for the actuall
> > page that is allocated when we _WRITE_ to the pipe.
> > 
> Yes, you are right. But this case indeed fail when on low memory machine 
> (4kb page size, 256/512M memory).

That's strange, I had a look at the code today again and as far as I can
tell we only check for user ulimit there.

What was the errno when the ioctl() has failed? Was it EPERM or ENOMEM?
The ENOMEM may have happened if the system overcommit was disabled and
the system was out of memory.

-- 
Cyril Hrubis
chrubis@suse.cz
