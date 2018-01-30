From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Tue, 30 Jan 2018 16:15:33 +0900
Subject: [LTP] [PATCH v2] skipfile: allow regular expressions
In-Reply-To: <20180122151926.GA16105@rei>
References: <1516089674-16119-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <20180122151926.GA16105@rei>
Message-ID: <008001d3999a$1e8a26a0$5b9e73e0$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Tuesday, January 23, 2018 12:19 AM
> To: Daniel Sangorrin
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] [PATCH v2] skipfile: allow regular expressions
> 
> Hi!
> > --- a/runltp
> > +++ b/runltp
> > @@ -692,10 +692,11 @@ main()
> >      fi
> >
> >      # Blacklist or skip tests if a SKIPFILE was specified with -S
> > +    # The SKIPFILE can contain regular expressions (e.g.: cron.*)
> >      if [ -n "${SKIPFILE}" ]; then
> >          for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
> >              case "${test_name}" in \#*) continue;; esac
> > -            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
> > +            sed -i "s/^\(${test_name}\)\s.*/\1 exit 32;/" alltests
> >          done
> >      fi
> 
> Looks good, but please update runltplite.sh as well.

Sorry for the delay. I found that my patch had a flaw while testing it on runltplite.sh.
For example, "rwtest.*" doesn't work for rwtest:  
rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f sync ..

The reason is that "rwtest.*"  matches too much. If I use "rwtest[a-zA-Z0-9]" as a regex on the skipfile
then it works as expected

Example:
$ STRING="rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f"
$ sed "s/^\(rwtest.*\)\s.*/\1 exit 32;/" <<< $STRING
    rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f exit 32  (BAD!!)
$ sed "s/^\(rwtest[a-zA-Z0-9]*\)\s.*/\1 exit 32;/" <<< $STRING
rwtest01 exit 32 (GOOD!!)

I think that the skipfile entries should only care about the testname, so "rwtest.*" should actually
work. I have tried modifying the sed instruction but I wasn't able to isolate the first occurrence.
Should I extract the test_name (first words, except blank lines) from alltests and match them
with the skipfile entries one by one in a loop?

Thanks,
Daniel




> --
> Cyril Hrubis
> chrubis@suse.cz



