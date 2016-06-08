From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 16:32:07 +0200
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <796099325.4641600.1465396303623.JavaMail.zimbra@redhat.com>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
 <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
 <20160608131515.GA27367@rei.lan>
 <1570517895.4619774.1465392983796.JavaMail.zimbra@redhat.com>
 <20160608135528.GB27367@rei.lan> <20160608140635.GC27367@rei.lan>
 <796099325.4641600.1465396303623.JavaMail.zimbra@redhat.com>
Message-ID: <20160608143207.GE27367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I was thinking the same as your patch below, but plus these changes:
> - remove call to do_cleanup in tst_run_tcases
> - add call to cleanup_ipc in do_cleanup
> - remove call to cleanup_ipc in do_exit
> - add call to do_cleanup in do_exit

So, the test library could exit only via do_exit() call and the whole
cleanup would be done in do_exit() just before the call to exit(),
right? Sounds good to me. Will you prepare a patch?

-- 
Cyril Hrubis
chrubis@suse.cz
