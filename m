From: Ankit Jain <ankitja@vmware.com>
Date: Tue, 4 May 2021 10:44:50 +0000
Subject: [LTP] [PATCH] realtime/func/pi-tests: testpi-2 parser
 indentation fix
In-Reply-To: <YI/gQjOJK3dtjiPr@pevik>
References: <1620029239-31643-1-git-send-email-ankitja@vmware.com>,
 <YI/gQjOJK3dtjiPr@pevik>
Message-ID: <SA1PR05MB8311C13BCB37A122FBB66337DD5A9@SA1PR05MB8311.namprd05.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi Ankit,
>
> > There is an indentation issue in parser for testpi-2
> > which causes incorect parsing of the logs.
>
> Thanks for your fix, merged!
>
> FYI the patch didn't apply, not sure why, I had to use patch to apply it
> (instead of git am). I guess it was wrongly generated, please make sure
> you use git format-patch properly.

Thanks Petr for merging the patch.
Sorry, you had to apply it through patch instead of git am.
I will take care of it from next time.

> If pi-tests are really working and worth to keep (one of my colleagues
> realtime expert in the past didn't see much value in them), it'd be good
> to rewrite these parsers to shell (to avoid unnecessary python3 dependency).

Is there any other test suite or project which supersede or replaces the pi-tests in LTP?

- Ankit

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210504/794de4d1/attachment.htm>
