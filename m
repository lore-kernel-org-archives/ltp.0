From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Dec 2016 15:51:25 +0000
Subject: [LTP] [PATCH v3 4/4] shell: fix echo -e bashisms, simplify code
In-Reply-To: <20161201152632.GA9941@rei.lan>
References: <20161129082240.16473-1-petr.vorel@gmail.com>
 <20161129082240.16473-4-petr.vorel@gmail.com>
 <20161201152632.GA9941@rei.lan>
Message-ID: <CAFEAcA9+OVKpPB0U4-fW3dC3xYarjsj1VLMMt0b_n6+nNvFc9w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1 December 2016 at 15:26, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
>> -    echo "${ME}: Sending $SIGSHOW signal to $1's process(es)..."
>> -    echo -e "\\n\\n\\nYour current session has been terminated.\\n\\n\\n" | \
>> +    printf "${ME}: Sending $SIGSHOW signal to $1's process(es)...\n"
>> +    printf "\\n\\n\\nYour current session has been terminated.\\n\\n\\n\n" | \
>
> I'm a bit puzzled by the double backslashes here. I guess that the
> double backslash is reduced by shell to a single backslash and then
> echo/printf command gets just plain old \n in ARGV[].

Yes. In shell double-quoted text backslashes function as an escape
character when they precede any of $ ` " \ <newline>.
So "Hello\\n" becomes "Hello\n" as the executed command
sees it, and then printf/echo interpret \n as the newline.
You could also write that as 'Hello\n', since single-quotes don't
do backslash-escaping, or indeed as "Hello\n", since 'n' isn't
one of the handful of punctuation characters that need backslash
escapes inside double-quotes, and the shell is required not to
give backslash any special meaning if it isn't followed by one
of those. (This is why the first 'printf' in the bit I quote
above works even though it's just "${ME} ...\n" rather than \\n.)

Conclusion: those \\n could be tidied up to be just \n if you
want, but they're harmless.

thanks
-- PMM
