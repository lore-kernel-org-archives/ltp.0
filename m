From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Jan 2021 18:00:31 +0800
Subject: [LTP] [RFC PATCH 0/5] CGroups
In-Reply-To: <87h7nxdptp.fsf@suse.de>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <CAEemH2dR+W8ypMED_xqw2JVO7E_Y0Kp+0iS=QVH_h2r0pDBVJA@mail.gmail.com>
 <87h7nxdptp.fsf@suse.de>
Message-ID: <CAEemH2ee-kFC2ax+ODL3SKsCrbFPKqfgu9oAPCbVGUCTarn5xw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> >> I have done a direct conversion of the test cases to the new API, but
> >> I am not sure that it makes sense to call tst_cgroup_move_current
> >> within the run method of a test because after the first iteration it
> >>
> >
> > Hmm, I feel that is a rare scenario in our real test. Mostly we
> > just need to set it once in a process.
>
> I suppose we can just move it into setup then?
>

For tests that only need a one-time CGroup setting we can, but for
multiple requirements of the same controller in many processes it
seems not working.



> > That's true, but it is mainly caused by different versions of
> > CGroup. We could NOT unify the unsupported behavior, so
> > maybe the wiser choice is to let _CPUSET test skipping(TCONF)
> > directly on CGroup_V2?
>
> Yes. I wonder if tst_cgroup_move_current should return a value to
> indicate it was a NOP? Or maybe it should throw an error when called on
> CGroup_V2 and it would have been a NOP?
>

That sound like we have to handle the returned value/error additionally?
If so, I'd prefer to encapsulate that in CGroup-lib.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210104/624a097e/attachment.htm>
