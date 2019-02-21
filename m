From: pvorel <pvorel@suse.de>
Date: Thu, 21 Feb 2019 15:50:03 +0100
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <20190221143021.GC17813@rei.lan>
References: <20190221112201.18324-1-chrubis@suse.cz>
 <87r2c12udf.fsf@rpws.prws.suse.cz> <20190221143021.GC17813@rei.lan>
Message-ID: <a1ada081ca1d7b620d9b5d4ef6d79520@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> Just a thought, but this is potentially a problem if lib C implementes
>> ustat in user land, but the system call still exists. Which I think is
>> more likely with an obsolete system call.
> 
> Good point. So it all depends on what we want to focus on, if we are
> after kernel, we should call the syscall directly, if we look at system
> functionality we should go after the libc one by default.
> 
> I guess that ideally we should test both, not sure how to achiveve that
> reasonably easily...
+1.

Petr
