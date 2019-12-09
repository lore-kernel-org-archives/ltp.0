From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 9 Dec 2019 03:26:38 -0500 (EST)
Subject: [LTP] [bug] userspace hitting sporadic SIGBUS on xfs (Power9,
 ppc64le), v4.19 and later
In-Reply-To: <f874ea14-becc-9c4b-2f2f-351573e6a751@sandeen.net>
References: <9c0af967-4916-4e8b-e77f-087515793d77@free.fr>
 <e9a171cc-6827-5c43-092a-9dcd8a997b5a@free.fr>
 <f874ea14-becc-9c4b-2f2f-351573e6a751@sandeen.net>
Message-ID: <35957501.15762152.1575879998305.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> On 12/6/19 6:09 PM, dftxbs3e wrote:
> > Hello!
> > 
> > I am very happy that someone has found this issue.
> > 
> > I have been suffering from rather random SIGBUS errors in similar
> > conditions described by the author.
> > 
> > I don't have much troubleshooting information to provide, however, I hit
> > the issue regularly so I could investigate during that.
> > 
> > How do you debug such an issue? I tried a debugger etc. but besides
> > crashing with SIGBUS, I couldnt get any other meaningful information.

If it's same issue, you could check if dropping caches helps.
Figure out what page is it with crash or systemtap and look at page->flags
and ((struct iomap_page *)page->private)->uptodate bitmap.

> 
> You may want to test the patch Christoph sent on the original thread for
> this issue.

Or v5.5-rc1, Christoph's patch has been merged:
  1cea335d1db1 ("iomap: fix sub-page uptodate handling")

