From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 2 Sep 2021 10:24:01 +0200
Subject: [LTP] [PATCH v5 3/3] controllers/cpuacct: fix rmdir failures on
 early test abort
In-Reply-To: <YTCI3O7Et+VvYJfc@pevik>
References: <20210901151655.95760-1-krzysztof.kozlowski@canonical.com>
 <20210901151655.95760-3-krzysztof.kozlowski@canonical.com>
 <YTCI3O7Et+VvYJfc@pevik>
Message-ID: <21179557-f1d9-4129-533e-eac6bfe8684b@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/09/2021 10:18, Petr Vorel wrote:
> Hi Krzysztof,
> 
> ...
>> -	if [ -d "$testpath/subgroup_1" ]; then
>> -		rmdir $testpath/subgroup_*
>> +	if [ "$testpath" ]; then
>> +		if [ -d "$testpath/subgroup_1" ]; then
>> +			rmdir $testpath/subgroup_*
>> +		fi
>> +		rmdir $testpath
>>  	fi
> 
>> -	rmdir $testpath
>> -
> 
> LGTM, but how about use `rm -rf' instead?
> 
> e.g.
> 
> if [ "$testpath" ]; then
> 	rm -rf $testpath
> fi
> 
> That could simplify checks. Or is it needed to use `rmdir' to make sure there is
> no content in the directory? I suppose check like this is needed in cleanup,
> thus no problem to use `rm -rf'.

It isn't the point of this patch. I don't add here rmdir - all this code
was here before. The only thing added here is to check whether the
"testpath" variable is set or not.

I think using rm -rf should work, but anyway it's a separate commit :)


Best regards,
Krzysztof
