From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Jun 2020 18:18:31 +0800
Subject: [LTP] [PATCH v2 1/4] lib: add new cgroup test API
In-Reply-To: <595558785.15122565.1591609722778.JavaMail.zimbra@redhat.com>
References: <20200601100459.32511-1-liwang@redhat.com>
 <CAEemH2ffNHY6Ej-Er5a4Ng_9zw+RX+wEBc0widntmYqDLNRqxw@mail.gmail.com>
 <20200602121232.GA22599@janakin.usersys.redhat.com>
 <CAEemH2d7OzG6jBZ15bYGRHm7ry-gVjzuwJYhbHp3yitB3_928w@mail.gmail.com>
 <20200603104314.GA12583@janakin.usersys.redhat.com>
 <CAEemH2ey08M+-ddqh1DNWSOWSi7RNYz8ho=MSPQryYHSqamffg@mail.gmail.com>
 <20200605101443.GA6826@janakin.usersys.redhat.com>
 <CAEemH2cCLY1htBYPm9tuefyzdg6EqmFRrcMin76kf_LcMA2f3A@mail.gmail.com>
 <595558785.15122565.1591609722778.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cDdCowDZEYVuqV4aTFgBK69CO10hhFRM2X-XHEazK1Tg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 8, 2020 at 5:48 PM Jan Stancek <jstancek@redhat.com> wrote:

> ...
>
> But there would be clear connection between function and variable.
>   new_path = tst_cgroup_get_path(cgroup_dir);
>

Yes, that's easier to understand the code workflow.

> vs.
>   tst_cgroup_get_path(cgroup_dir);
>   // fyi, tst_cgroup_new_path is updated as side-effect of call above
>   // What other calls do update tst_cgroup_new_path? Have a look at
> implementation.

...
>
> That makes it somewhat better, since it's only concern of library code now.
> But since there are no tests using "tst_cgroup_new_path", does it still
> need to be global variable?
>

Sure, we could delete tst_cgorup_mnt/new_path variables, since we have
tracking all mount paths in the list, so it will be easy to find new_path
in each
function.

Hope v4 is the final version:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200608/5ecc6f74/attachment.htm>
