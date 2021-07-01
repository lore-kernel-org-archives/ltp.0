From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Jul 2021 13:58:01 +0800
Subject: [LTP] [RFC] Limit the tmpfs size on mounting
In-Reply-To: <YNw3ePbVhio3s9JX@yuki>
References: <CAEemH2da0dOeKpnZZ6+A696gFL+nDAiP7UL9tqm68JH8KO-Qkw@mail.gmail.com>
 <YNw3ePbVhio3s9JX@yuki>
Message-ID: <CAEemH2dQOWgBMc8H+oY81B-ppbr9wRVPey46-xFLvAyW7nG7vA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:


> I guess that appending '-o size ...' to the mount flags in prepare_device()
> is reasonable, but instead of hardcoing the value we should do the same
> as we do with the loop devices and the size should be
> MAX(tst_test->dev_min_size, DEV_SIZE_MB).
>

Yes, dynamically setting the size is better.


> > /dev/loop0                             tmpfs     126G   23G  104G  18%
>
> Also it looks like should pass something as "ltp-tmpfs" instead of the
> "/dev/loopX" string in a case of "tmpfs" filesystem in order not to
> confuse people...
>

Quite good proposals, I have sent two patches for achieving the ideas.

Thanks!
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210701/c31bf5ad/attachment.htm>
