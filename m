From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Jun 2019 17:59:58 +0200
Subject: [LTP] [PATCH] README: Add note about testing with Travis CI
In-Reply-To: <20190605153529.GA29218@rei.lan>
References: <20190605135641.1848-1-pvorel@suse.cz>
 <20190605153529.GA29218@rei.lan>
Message-ID: <20190605155958.GA22233@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Maybe we should explain why this is a good idea, something as:

> It's a good idea to test patches on Travis CI before posting to mailing
> list. Our travis setup covers various architectures and distributions in
> order to make sure LTP compiles cleanly on most common configurations.
Thanks, good idea. Acking this?

+
+It's a good idea to test patches on Travis CI before posting to mailing
+list. Our travis setup covers various architectures and distributions in
+order to make sure LTP compiles cleanly on most common configurations.
+For testing you need to sign up to Travis CI, enable running builds on your LTP fork on
+https://travis-ci.org/account/repositories and push your branch.


Kind regards,
Petr
