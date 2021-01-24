From: Li Wang <liwang@redhat.com>
Date: Sun, 24 Jan 2021 12:32:51 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <87y2glxv3x.fsf@oc8242746057.ibm.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com> <YAgmPjaf8iRn20x2@pevik>
 <CAEemH2cseOGtSem9vhChygLNeYz6E0bVEu+u-UH8agLBoHJo4Q@mail.gmail.com>
 <CAEemH2e=ySuT+JEoDkF0e0TYeooeZbT0mu4D+47NLjwvsPecnA@mail.gmail.com>
 <87y2glxv3x.fsf@oc8242746057.ibm.com>
Message-ID: <CAEemH2cwsTCUh5QF2EkqR+0q8S2TtCycyOiFLnk-W5RoBXKLBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex, Petr,

Patch applied, thanks!

Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

...
> > But I still think the swapping01 not very precise to some degree.
> > We probably need to rewrite it someday but currently, I have no better
> > idea.
>
> 100% agree. It is very fragile. I was thinking maybe we could find out
> how much swap space is assigned to a *particular* process, maybe something
> in /proc/ can be used ?


Sounds practicable, we can have a try.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210124/2a0309bb/attachment.htm>
