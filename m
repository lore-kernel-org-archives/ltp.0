From: Li Wang <liwang@redhat.com>
Date: Wed, 5 Aug 2020 18:31:56 +0800
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <20200805092703.GB5522@yuki.lan>
References: <20200731121508.12805-2-chrubis@suse.cz>
 <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
 <20200805092703.GB5522@yuki.lan>
Message-ID: <CAEemH2dAmvMAQxJeRrNGnGo0Gw_Szn8CfOho3KNZTHoCBfUkJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Great idea, I've added these changes to the first patch in the series
> before I pushed it.
>

There is still a DIR output at:
  include/mk/generic_trunk_target.inc:84:     echo "DIR $$dir"; \

Not sure it is on purpose or forgot removing?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200805/97f721ca/attachment.htm>
