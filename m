From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Mar 2017 16:30:51 +0100
Subject: [LTP] [PATCH] setxattr: prefer not to run tests in tmpfs
In-Reply-To: <CAMhs6YznbBmsoY5B1zTA8Dg5+h9sD3GmhKdhgKoxSasraKYtGQ@mail.gmail.com>
References: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
 <20170320151104.GB6102@rei.lan>
 <CAMhs6YznbBmsoY5B1zTA8Dg5+h9sD3GmhKdhgKoxSasraKYtGQ@mail.gmail.com>
Message-ID: <20170320153051.GC6102@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We can either exit the test with TCONF if /tmp is on tmpfs or format and
> > mount a device and run these testcases on a file created there in that
> > case.
> 
> Thanks for sharing your thoughts. It is clear now.
> 
> However, what about tests which fails by default on tmpfs like "fcntl" tests?
> Should we default to the "/tmp" directory rather than mounting another device
> and run the tests again ?

Have a look at ftruncate04.c testcase, that falls back to mounting a
device over the directory the test uses if needed.

-- 
Cyril Hrubis
chrubis@suse.cz
