From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jul 2019 17:48:55 +0800
Subject: [LTP] [PATCH v2] syscalls/mbind0{2,3,4}: Add basic mbind tests
In-Reply-To: <20190723093310.GA22630@rei.lan>
References: <20190722150316.27395-1-chrubis@suse.cz>
 <CAEemH2dapin31=WrPsA97wgX=2d5rzQy8+D7LVta6nr6BwFN5A@mail.gmail.com>
 <20190723093310.GA22630@rei.lan>
Message-ID: <CAEemH2dNcNmrqgg2o2acOk3=aYg9A4HpPnHGEQfjyORm_98pUw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 23, 2019 at 5:33 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > Why not test MPOL_INTERLEAVE for mbind02? I guess it also makes sense
> > to add here.
>
> Good catch, we have a bitmask with a single node, so I guess that this
> would work as well. Have you tested it?

Yes, it works for me.

> > I remember there are some ppc64le which have non-continuous numa nodes
> > in hardware configuration. I'm not sure if that special config will
> > break the mbind04 test, will update details to you after I run this
> > test on such a system.
>
> The LTP NUMA library should handle that, the nodes->cnt is the
> lenght of the NUMA map and the actual node ids are in the nodes->map[]
> array.

You're right, I verified that it doesn't affect by the non-continuous
node system.

-- 
Regards,
Li Wang
