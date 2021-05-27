From: Li Wang <liwang@redhat.com>
Date: Thu, 27 May 2021 12:51:09 +0800
Subject: [LTP] [RFC PATCH 1/1] doc: Split test-writing-guidelines
In-Reply-To: <YK8d5APc1VZ0Q7T+@pevik>
References: <20210526154949.4473-1-pvorel@suse.cz>
 <CAEemH2ecppttvGW1JeJ_E=w1eUJYEY8+Sx8Euztn2MhRYykEKQ@mail.gmail.com>
 <CAEemH2fGaxQuTvpV1gEp8hVoeHo=42ikSRYs+5RmCuJQfJQa-g@mail.gmail.com>
 <YK8d5APc1VZ0Q7T+@pevik>
Message-ID: <CAEemH2doGFdk395L5t7cGBKT63AzORNjEU4=H6qQFbXjO2xCTA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 27, 2021 at 12:19 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li, all,
>
> > > > https://github.com/pevik/ltp/wiki/Test-Writing-Guidelines
> > > > https://github.com/pevik/ltp/wiki/C-Test-API
>
> > Seems we have a similar guideline "c-test-tutorial-simple.txt",
> > maybe better to combine them together?
> I'd prefer to keep them separate. Because otherwise page gets long again.
> But I'd consider to unify names ("LTP C Test API" vs. "C Test Case Tutorial"
> - API vs. Case).

No problem, I'm OK with unifying names.

And yes, we can rename with the same prefix start on purposely to make
them keep nearby in alphabetical sorting.

> > > > https://github.com/pevik/ltp/wiki/Shell-Test-API
>
> > Forgot to mention, with the increased number of docs, do you think it
> > necessary to create an index for including all documents in a sort?
> There is list of pages on the right. But as it's sorted alphabetically,
> it's not enough. Maybe we should add this list to README.md and to HOME wiki
> page.

To HOME wiki sounds good, we can do a simple triage in there.

Thanks a lot for the documentation work!

-- 
Regards,
Li Wang

