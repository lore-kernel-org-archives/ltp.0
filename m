From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 12 Mar 2021 22:52:45 +0800
Subject: [LTP] [PATCH 2/2] docparse: Unify Description and Algorithm
 titles
In-Reply-To: <YEtKL70YWfv+yzyZ@pevik>
References: <20210308160122.24522-1-pvorel@suse.cz>
 <20210308160122.24522-2-pvorel@suse.cz> <YEtFmok1oxZjcKVi@yuki.lan>
 <YEtKL70YWfv+yzyZ@pevik>
Message-ID: <604B803D.6090704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

? 2021/3/12 19:02, Petr Vorel ??:
> Hi,
>
>>>   				# fix formatting for asciidoc [DOCUMENTATION] =>  *DOCUMENTATION*
>>                                                                                    ^
>> 										  This
>> 										  should
>> 										  be
>> 										  *Documentation*
>>>   				if ($doc =~ s/^\[(.*)\]$/$1/) {
>>> -					$doc = paragraph(bold($doc));
>>> +					$doc = paragraph(bold(ucfirst(lc($doc))));
>>>   				}
>>>   				$content .= "$doc\n";
>> Other than that it looks good.
> Thanks, fixed and patchset merged.
>
> Yang, sorry I didn't put it into docparse.c.
Hi Petr,

Never mind, we can do it later when someone needs to unify these titles 
in metadata.json.

Best Regards,
Xiao Yang
>> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>
> .
>



