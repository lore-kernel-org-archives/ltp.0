From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Jun 2021 18:21:54 +0800
Subject: [LTP] [RFC PATCH 3/3] doc: Update LTPROOT and PATH environment
 variables
In-Reply-To: <YMnMDulm9C+SDdXa@pevik>
References: <20210615163307.10755-1-pvorel@suse.cz>
 <20210615163307.10755-4-pvorel@suse.cz>
 <CAEemH2eLDk8rb3wUMCjz6Txo333f4Mae1AWZy0Rt6mTYuvYf6w@mail.gmail.com>
 <YMnMDulm9C+SDdXa@pevik>
Message-ID: <CAEemH2e8K27bABdo=DQJUbiVKewex=EK27DT3P9oNWhK3bB7mQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 16, 2021 at 6:02 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li,
>
> > > -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> > > +$ LTPROOT=/opt/ltp testcases/bin/wc01.sh
>
> > I'm wondering does this really work? or, did I miss something?
> Oops, I'm sorry to send broken patchset, this is obviously wrong.
> We have to keep path set when calling script directly, because tst_test.sh would
> be missing.
>
> when in LPTROOT directory:
> LTPROOT=/opt/ltp testcases/bin/wc01.sh
> testcases/bin/wc01.sh: line 13: .: tst_test.sh: file not found
>
> But we don't want to set path in each script nor load library as
> . testcases/bin/tst_test.sh
>
> Thus I guess setting PATH in LTP API doesn't make much sense if it works only
> when using LTP runner (runltp{,-ng}, which BTW set path as well.

Exactly :).

-- 
Regards,
Li Wang

