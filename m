From: Li Wang <liwang@redhat.com>
Date: Fri, 31 Jan 2020 17:14:56 +0800
Subject: [LTP] [PATCH] Taunt OOM killer in fork12 setup()
In-Reply-To: <20200130161337.31614-1-mdoucha@suse.cz>
References: <20200130161337.31614-1-mdoucha@suse.cz>
Message-ID: <CAEemH2f7s+q1upnaikCnQZSqxb-xgdN73aPxhKhLo2i5_M7FkA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 31, 2020 at 12:13 AM Martin Doucha <mdoucha@suse.cz> wrote:

> On a system with low memory, fork12 can trigger OOM killer before it hits
> any fork() limits. The OOM killer might accidentally kill e.g. the parent
> shell and external testing tools will assume the test failed.
>
> Set high oom_score_adj on the fork12 process so that the OOM killer focuses
> on it and its children.
>

It sounds more like the OOM-Killer defect but not fork12. What we do for
that is to protect the parent shell and its harness to avoid
oom_kill_process() acting on them.

On the other side, if we do raise the oom score of fork12, that would not
guarantee OOM-Killer do right evaluation but just makes fork12 easily to be
killed in testing.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200131/c7dddc10/attachment-0001.htm>
