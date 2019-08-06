From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Aug 2019 18:48:40 +0200
Subject: [LTP] [PATCH v2 4/4] make,
 travis: Remove -Werror-implicit-function-declaration
In-Reply-To: <20190802150445.10984-5-pvorel@suse.cz>
References: <20190802150445.10984-1-pvorel@suse.cz>
 <20190802150445.10984-5-pvorel@suse.cz>
Message-ID: <20190806164840.GA29935@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> and add it to Travis CI builds.

> Previously it was passed only to Android build. Generally Werror flags
> should be on for development but disabled for releases and production.
> We don't have any configure flag stating development build, so using it
> only in Travis CI should be sufficient (although we lost lost this check
> for Android as we don't test it in our Travis CI setup).

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Travis build: https://travis-ci.org/pevik/ltp/builds/566982062
This one replaced by https://patchwork.ozlabs.org/patch/1142959/

Travis build: https://travis-ci.org/pevik/ltp/builds/568461383

Kind regards,
Petr
