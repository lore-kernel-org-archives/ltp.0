From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Aug 2019 12:41:27 +0200
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
Message-ID: <20190826104127.GA14729@haruka>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do you see this LTP prot_hsymlinks failure on linux next 20190823 on
> x86_64 and i386 devices?
> 
> test output log,
> useradd: failure while writing changes to /etc/passwd
> useradd: /home/hsym was created, but could not be removed

This looks like an unrelated problem, failure to write to /etc/passwd
probably means that filesystem is full or some problem happend and how
is remounted RO.

I do not see the kernel messages from this job anywhere at the job
pages, is it stored somewhere?

-- 
Cyril Hrubis
chrubis@suse.cz
