From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Sep 2020 16:47:51 +0200
Subject: [LTP] [PATCH 8/9] syscalls/ipc: Add shmctl IPC_SET test
In-Reply-To: <CAEemH2c6CKEgyUtk3B=Gm+GL4wH=3cR=h3TA2d7WHg1-0Vg5pg@mail.gmail.com>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-9-chrubis@suse.cz>
 <CAEemH2c6CKEgyUtk3B=Gm+GL4wH=3cR=h3TA2d7WHg1-0Vg5pg@mail.gmail.com>
Message-ID: <20200907144751.GC10649@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Maybe we also need to consider a situation that timestamp is just as
> previous value?
> i.e.
>     if (ds.shm_ctime - old_ctime > 10 || ds.shm_ctime - old_ctime == 0)

I will change that to a range check, I.e. the ds.shm_ctime must be
greater than old_ctime and smaller than old_ctime + 10.

-- 
Cyril Hrubis
chrubis@suse.cz
