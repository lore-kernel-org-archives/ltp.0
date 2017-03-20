From: Maxin B. John <maxin.john@gmail.com>
Date: Mon, 20 Mar 2017 17:20:54 +0200
Subject: [LTP] [PATCH] setxattr: prefer not to run tests in tmpfs
In-Reply-To: <20170320151104.GB6102@rei.lan>
References: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
 <20170320151104.GB6102@rei.lan>
Message-ID: <CAMhs6YznbBmsoY5B1zTA8Dg5+h9sD3GmhKdhgKoxSasraKYtGQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Mar 20, 2017 at 5:11 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> NACK tests must not create any files outside it's temporary directory.

Ok.

> We can either exit the test with TCONF if /tmp is on tmpfs or format and
> mount a device and run these testcases on a file created there in that
> case.

Thanks for sharing your thoughts. It is clear now.

However, what about tests which fails by default on tmpfs like "fcntl" tests?
Should we default to the "/tmp" directory rather than mounting another device
and run the tests again ?

> --
> Cyril Hrubis
> chrubis@suse.cz

Best Regards,
Maxin
