From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 May 2021 06:19:48 +0200
Subject: [LTP] [RFC PATCH 1/1] doc: Split test-writing-guidelines
In-Reply-To: <CAEemH2fGaxQuTvpV1gEp8hVoeHo=42ikSRYs+5RmCuJQfJQa-g@mail.gmail.com>
References: <20210526154949.4473-1-pvorel@suse.cz>
 <CAEemH2ecppttvGW1JeJ_E=w1eUJYEY8+Sx8Euztn2MhRYykEKQ@mail.gmail.com>
 <CAEemH2fGaxQuTvpV1gEp8hVoeHo=42ikSRYs+5RmCuJQfJQa-g@mail.gmail.com>
Message-ID: <YK8d5APc1VZ0Q7T+@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, all,

> > > https://github.com/pevik/ltp/wiki/Test-Writing-Guidelines
> > > https://github.com/pevik/ltp/wiki/C-Test-API

> Seems we have a similar guideline "c-test-tutorial-simple.txt",
> maybe better to combine them together?
I'd prefer to keep them separate. Because otherwise page gets long again.
But I'd consider to unify names ("LTP C Test API" vs. "C Test Case Tutorial"
- API vs. Case).

Kind regards,
Petr

> > > https://github.com/pevik/ltp/wiki/Shell-Test-API

> Forgot to mention, with the increased number of docs, do you think it
> necessary to create an index for including all documents in a sort?
There is list of pages on the right. But as it's sorted alphabetically,
it's not enough. Maybe we should add this list to README.md and to HOME wiki
page.

Well, I have to say I hate github Wiki features. There is no table of content,
for page, we cannot change list of pages, ...

Kind regards,
Petr
