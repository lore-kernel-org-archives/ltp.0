From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 1 Nov 2019 04:54:33 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <CAEemH2eT1aAujLbt7HtuBo1gpE2OadYFuBCf5fiaVKxboj7TtQ@mail.gmail.com>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
 <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
 <20191030144649.GA25642@dell5510>
 <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
 <CAEemH2dO95d2_CZyMpE4fM8CcC+p0ou9XfA43sS9fX0LmQBWoQ@mail.gmail.com>
 <2003376860.9886044.1572511989903.JavaMail.zimbra@redhat.com>
 <CAEemH2eT1aAujLbt7HtuBo1gpE2OadYFuBCf5fiaVKxboj7TtQ@mail.gmail.com>
Message-ID: <53174843.10094606.1572598473354.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Thu, Oct 31, 2019 at 4:53 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> > ----- Original Message -----
> > > > Above was RHEL7. Do you expect different outcome on RHEL8?
> > > > I was looking at upstream sources too and it looked similar.
> > > >
> > > > Anyway, I don't think this part is an issue, test will skip it
> > > > because "comm" doesn't match.
> > > >
> > > > We can tweak 'ac_btime' condition, but I think the test will remain
> > > >
> > >
> > > How much time of the ac_btime shaking to be tolerated is proper?
> >
> > I wanted to go with 1 sec:
> >
> 
> I'm ok with that. Seems no better way so far.

I want to look at this a bit more, and add some extra traces to kernel.

