From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Dec 2020 13:21:33 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: add getopts to tst_ping()
In-Reply-To: <4b2f0cc7-2caf-34a5-12c2-6d0c33bfcbf0@oracle.com>
References: <20201208162440.14538-1-alexey.kodanev@oracle.com>
 <X9M4ol3AqYU8YtZQ@pevik>
 <4b2f0cc7-2caf-34a5-12c2-6d0c33bfcbf0@oracle.com>
Message-ID: <X9NkTfGP4WygA/6l@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > BTW -f does not require root (but effectively it's required by netns setup).

> Hi Petr,

> Are sure -f doesn't require root?
Sorry, I was wrong (tested on latest iputils release):

ping localhost -f
ping: cannot flood; minimal interval allowed for user is 200ms

> >> * Replace '-i 0' with '-f'
> > Out of curiosity, why flood ping is better than -i 0?
> > More effective stressing?

> I think it's better to use the option that is specially made
> for this, isn't it? AFAIK, -f won't do verbose printing, though
> we could add -q too along with -i 0...

+1

Kind regards,
Petr
