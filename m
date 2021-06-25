From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Jun 2021 16:21:30 +0800
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
 <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
Message-ID: <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 25, 2021 at 3:31 AM Krzysztof Kozlowski <
krzysztof.kozlowski@canonical.com> wrote:

> On 17/06/2021 09:07, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > This is a resend of previous Github pull:
> > https://github.com/linux-test-project/ltp/pull/830
> >
> > The patches fix several test failures we are hitting since months, see:
> > https://bugs.launchpad.net/bugs/1829979
> > https://bugs.launchpad.net/bugs/1829984
> >
> > Best regards,
> > Krzysztof
> >
> >
> > Krzysztof Kozlowski (3):
> >   controllers/memcg: accept range of max_usage_in_bytes
> >   controllers/memcg: accept range of usage_in_bytes
> >   controllers/memcg: accept non-zero max_usage_in_bytes after reset
>
>
> Hi everyone,
>
> The patchset got positive LGTM on the Github. Any further comments for
> it or can it be applied?
>

I slightly agree with Richard that we need an explanation/investigation
on where the 32*PAGE_SIZE comes from. Otherwise, we are very possible
to mask a counter bug if only to make the test happy.

Forgive me pour cold water on the method though it looks good in coding:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210625/0f253bc8/attachment.htm>
