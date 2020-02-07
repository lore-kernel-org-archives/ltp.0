From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 7 Feb 2020 12:29:28 +0100
Subject: [LTP] [PATCH v2 1/3] Redesign TST_RETRY_FUNC()
In-Reply-To: <20200207112236.16462-1-mdoucha@suse.cz>
References: <20200207112236.16462-1-mdoucha@suse.cz>
Message-ID: <8d022169-5c09-8b94-38b8-bdba679a9ea0@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/7/20 12:22 PM, Martin Doucha wrote:
> The TST_RETRY_FUNC() macro requires a single return value that'll be considered
> success. This cannot be used with system calls that e.g. return a new file
> descriptor because the success value is somewhat unpredictable.
> 
> Redesign TST_RETRY_FUNC() to accept arbitrary macro/function ECHCK as the second
> parameter for validating the FUNC return value.
> - The loop will end succesfully if ECHCK(ret) evaluates to non-zero.
> - The loop will fall through on timeout instead of calling tst_brk().
> - errno will be cleared before every FUNC call.
> - Add standard check macros for the most common call conventions:
>   - TST_RETVAL_EQ0(x) - x == 0
>   - TST_RETVAL_NOTNULL(x) - x != 0 or x != NULL
>   - TST_RETVAL_GE0(x) - x >= 0
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

Sorry, I forgot to add this to the commit message:
Co-Developed-by: Cyril Hrubis <chrubis@suse.cz>

Please add it before pushing.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
