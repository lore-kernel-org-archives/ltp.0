From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jul 2021 14:45:56 +0200
Subject: [LTP] [PATCH 3/3] Add lockdown checks to init_module* and
 finit_module* tests
In-Reply-To: <e6033278-8e27-eed5-5f36-1dd09e68bf5a@suse.cz>
References: <20210720103941.9767-1-mdoucha@suse.cz>
 <20210720103941.9767-3-mdoucha@suse.cz> <YPa7bSB8pNPrBDn8@yuki>
 <e6033278-8e27-eed5-5f36-1dd09e68bf5a@suse.cz>
Message-ID: <YPbFhOEjYr9nOryX@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm slightly afraid that the order of checks may change over the time
> > and we will get EPERM in all these cases, but maybe I'm just overly
> > cautious. Other than this the code looks good.
> 
> I don't think we need to worry about that. With root privileges, the
> EPERM error is returned when a kernel module does not have a valid
> signature. How would something that is not even a valid kernel module in
> the first place fail that check?
>
> The only subtests that actually try to load a valid kernel module are
> null-param, invalid-param and module-exists. All three of them now
> handle lockdown correctly.

Right, we have to be able to read the signature in order to produce
EPERM and the same for the init_module() there has to be a pointer to
a module data that kernel can check the signature from.

Patch pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
