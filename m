From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Feb 2017 13:06:36 +0100
Subject: [LTP] travis: getting emails for other people's forks
In-Reply-To: <CAFEAcA8=fTOTi1AkS6hgGWHQji=Hh8aUQGDZk5zW9UJMMnOmqw@mail.gmail.com>
References: <20170201083124.6b3rrrx46xf2457b@dell5510>
 <CAFEAcA8=fTOTi1AkS6hgGWHQji=Hh8aUQGDZk5zW9UJMMnOmqw@mail.gmail.com>
Message-ID: <20170202120636.d2wx64wggx32kdso@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Peter,

> That issue 6100 includes some comments that suggest that you
> can work around this with the same thing we do in QEMU's
> .travis.yml to only send notifications to IRC for the official
> fork. Basically you use
>   recipients:
>     secure: "<encrypted string>"

> where the encrypted string is generated using the commandline
> utility:

> travis encrypt -r github-repo-name "target-email@wherever.com"

> This sets this up so that only the named github repo will decrypt
> the encrypted bit of config and apply it -- forks won't be able
> to decrypt it and so will not send emails.

> example:
> https://github.com/facebook/flow/commit/8ec791d5d1623aafa144de4e0692d40352125ec9

Thanks for explanation, I'll check it again. I must have used wrong github repo name
when testing.


Kind regards,
Petr
