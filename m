From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Mar 2021 09:15:03 +0100
Subject: [LTP] [PATCH] splice02: Generate input in C
In-Reply-To: <YEcPvIckAEbmMBi9@pevik>
References: <20210308154421.2002-1-pvorel@suse.cz> <YEZTd+CT/Gag1ejK@yuki.lan>
 <YEZoCOqGeb4dVnpV@pevik> <YEZs/MTW0Pcyz6Ml@yuki.lan>
 <YEcPvIckAEbmMBi9@pevik>
Message-ID: <YEcuh38X83GX1RPL@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That would not work, the pipe is supposed to be in the runtest file.
> Do you want to test that runtest is working with pipe?

Yes, that was the original idea behind adding the splice test there.

> I considered anything but shell script with getopt parameters a bit strange and
> thought it'd be removed in new shell runner. But obviously you want to keep it.

We will have to keep the functionality for the time being.

> But in case of failure script don't detect it. e.g.:
> 
> echo "SUCCESS" | cat /asdf
> cat: /asdf: No such file or directory
> 
> => there is no TFAIL/TBROK/TCONF. Not sure if all users check exit status (which
> they should now, because that is the only common thing so far).

Well yes, I guess that we can do something as:

echo "SUCCESS" | grep -q "SUCCESS"

Which at least returns 1 if the grep fails.

-- 
Cyril Hrubis
chrubis@suse.cz
