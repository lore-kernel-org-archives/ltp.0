From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Nov 2017 10:09:41 +0800
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <20171129183148.GA3573@x230>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
 <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
 <20171129082743.d5i5stufxmn25twr@dell5510>
 <CAEemH2fG=O7vVj=xyY58gwQLkq5JUw4fa4yaUEMAyoJfWE0V_A@mail.gmail.com>
 <20171129145249.6wfxny7sqnwchrjk@dell5510> <20171129154227.GB15160@rei>
 <20171129183148.GA3573@x230>
Message-ID: <CAEemH2dkTZDmdv384mmO-UqkStxNS6J-isiRhDXKrVahAc=a1w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 30, 2017 at 2:31 AM, Petr Vorel <pvorel@suse.cz> wrote:
> Hi Li, Cyril,
>
>> > You're running configure without flags. For travis we run full build, e.g. with
>> > --with-open-posix-testsuite --with-realtime-testsuite flags.
>
>> Can we, pretty please, have out-of-tree build without the realtime and
>> openposix testsuite for now. That way we will not break what is
>> supposedly working for now...
> Sure
>
> If you don't mind Li, I'll propose in v2 mine version of out-of-tree function and not yours due things I've noted. But thanks a lot for your input!

Of course not, feel free to use yours.That's just a simple draft I gave above.


-- 
Li Wang
liwang@redhat.com
