From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri, 22 Jan 2021 08:56:50 +0100
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <CAEemH2e=ySuT+JEoDkF0e0TYeooeZbT0mu4D+47NLjwvsPecnA@mail.gmail.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com> <YAgmPjaf8iRn20x2@pevik>
 <CAEemH2cseOGtSem9vhChygLNeYz6E0bVEu+u-UH8agLBoHJo4Q@mail.gmail.com>
 <CAEemH2e=ySuT+JEoDkF0e0TYeooeZbT0mu4D+47NLjwvsPecnA@mail.gmail.com>
Message-ID: <87y2glxv3x.fsf@oc8242746057.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
Date: Fri, 22 Jan 2021 08:56:45 +0100
Message-ID: <87zh11xv42.fsf@oc8242746057.ibm.com>
X-Trend-IP-HD: ip=[9.171.79.240]sender=(egorenar@linux.ibm.com)recipient=<ltp@lists.linux.it;pvorel@suse.cz;liwang@redhat.com>

Li Wang <liwang@redhat.com> writes:

> Hi Alex, Petr,
>
> I'm going to apply Alex's patch after a round of testing[1].
> Because giving more time waiting for swap memory to
> settle is no harm to test, at least help to get rid of failures
> observed on LPAR so far.

Great, thank you very much :) I also think it shouldn't make the test
behave worse.

>
> But I still think the swapping01 not very precise to some degree.
> We probably need to rewrite it someday but currently, I have no better
> idea.

100% agree. It is very fragile. I was thinking maybe we could find out
how much swap space is assigned to a *particular* process, maybe something
in /proc/ can be used ?

>
> [1] Running a stress-ng to eat some available memory in the
> background, then swapping01 easily hit the heavy-swap issue.
> This could be proved that it influenced by deamon allocate/free
> memory during testing.
>
> # stress-ng to eat memory after starting swapping01
>

I also observed that with stress-ng.


Regards
Alex
