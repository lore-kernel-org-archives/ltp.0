From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Jan 2017 10:17:02 +0800
Subject: [LTP] [PATCH v2 4/4] ltp/numa: add new test11
In-Reply-To: <20170119115713.GA9193@rei.lan>
References: <1481710151-18453-1-git-send-email-liwang@redhat.com>
 <20170119115713.GA9193@rei.lan>
Message-ID: <CAEemH2fMy6aJbY+ChEp2BNdpeM7c6KS-62R7ex+Dh=KkwUmfMA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 19, 2017 at 7:57 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> I've pushed all patches but this one (thanks!) as I added a few more
> fixes for the testcase as well. The most important is the one that makes
> the numa01.sh script wait util the helper allocates memory instead of
> sleeping and hoping for the best.
>
> Can you please update this patch so that the newly added test matches
> the changes I did to the rest of the testcases?

Sure, let me have a look then post a new one.

Thanks for your reviewing patiently.



-- 
Regards,
Li Wang
Email: liwang@redhat.com
