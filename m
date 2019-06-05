From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Jun 2019 17:35:29 +0200
Subject: [LTP] [PATCH] README: Add note about testing with Travis CI
In-Reply-To: <20190605135641.1848-1-pvorel@suse.cz>
References: <20190605135641.1848-1-pvorel@suse.cz>
Message-ID: <20190605153529.GA29218@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +It's recommended to test patches on Travis CI before posting to mailing list

Maybe we should explain why this is a good idea, something as:

It's a good idea to test patches on Travis CI before posting to mailing
list. Our travis setup covers various architectures and distributions in
order to make sure LTP compiles cleanly on most common configurations.

> +(sign up to Travis CI and enable running builds on your LTP fork on https://travis-ci.org/account/repositories).
> -- 
> 2.21.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
