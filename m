From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 11:42:44 +0200
Subject: [LTP] [PATCH 2/3] binfmt_misc02.sh: Use "command -v" instead of
 "which"
In-Reply-To: <a695f1b3-ce44-b4b5-6a11-edd75df093fc@jv-coder.de>
References: <20210818091224.27578-1-pvorel@suse.cz>
 <20210818091224.27578-3-pvorel@suse.cz>
 <a695f1b3-ce44-b4b5-6a11-edd75df093fc@jv-coder.de>
Message-ID: <YRzWFKFIBG2HlD3H@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > -	6) verify_binfmt_misc ":tmagic:M:0:This::$(which cat):" \
> > +	6) verify_binfmt_misc ":tmagic:M:0:This::$(type cat):" \
> >   			      "$TST_DATAROOT/file.magic" "0";;
> This does not match the description, you say you replace which with command,
> but actually you replaced it with type.
Good catch, thanks! Actually, this commit is wrong, it *must* use
"command -v".

Kind regards,
Petr
