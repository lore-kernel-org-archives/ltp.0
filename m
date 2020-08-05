From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Aug 2020 12:40:28 +0200
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <CAEemH2dAmvMAQxJeRrNGnGo0Gw_Szn8CfOho3KNZTHoCBfUkJQ@mail.gmail.com>
References: <20200731121508.12805-2-chrubis@suse.cz>
 <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
 <20200805092703.GB5522@yuki.lan>
 <CAEemH2dAmvMAQxJeRrNGnGo0Gw_Szn8CfOho3KNZTHoCBfUkJQ@mail.gmail.com>
Message-ID: <20200805104028.GC5522@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There is still a DIR output at:
>   include/mk/generic_trunk_target.inc:84:     echo "DIR $$dir"; \
> 
> Not sure it is on purpose or forgot removing?

That's the one for the clean target, we may clean up 'make clean' output
as well, but without further changes this shall stay.

-- 
Cyril Hrubis
chrubis@suse.cz
