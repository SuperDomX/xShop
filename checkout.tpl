<link rel="stylesheet" type="text/css" href="/x/html/layout/watchtower/css/shopfrog.css">

<style type="text/css">
	.medium .carousel-indicators li{
		width: 5px;
		height: 5px;
	}

	.board-links li{
		display: inline-block;
		margin-bottom: 4px;
	} 

	.panel{
		background-color: rgba(0,0,0,0.25);
	}
 </style>
	<div id="product-board">

        

		{if $data.items|count > 0}
		 
			<div class="product col-md-6 static no-padding">
				<form id="shipping-address" class="form-horizontal label-left"
                          method="post"
                          onsubmit="return window.checkout.order(event);">
					<div class="text-align-center text">
						<h1>Ship To <i class="fa fa-truck fa-flip-horizontal"></i> </h1>
						<p class="lead">
							{$shop_intro}
						</p> 
					
                        <div class="control-group">
                            <label for="email" class="control-label">Email <span class="email">*</span></label>
                            
                            <div class="controls form-group">
                                <div class="col-xs-12 col-sm-6">
                                    <input id="email" class="form-control" required="required" type="email" value="{$user.email}" name="email">
                                </div>
                            </div>
                        </div> 
                    	<div class="control-group">
                            <label for="address" class="control-label">Address <span class="required">*</span></label>
                           <!--  <div class="controls form-group">
                                <div class="col-xs-12 col-sm-8">
                                    <div class="input-group">
                                        <input id="address" class="form-control" type="text"
                                               name="address">
                                        <span class="input-group-btn">
                                             <select id="address-type" class="selectpicker" data-style="btn-default">
                                                 <option>Mobile</option>
                                                 <option>Home</option>
                                                 <option>Work</option>
                                             </select>
                                        </span>
                                    </div>
                                </div>
                            </div> -->
                            <div class="controls form-group">
                                <div class="col-xs-12 col-sm-6">
                                    <input id="address" class="form-control" required="required" type="text" value="{$address.primary_street_line}" name="address[primary_street_line]">
                                    <input id="address2" class="form-control" type="text" value="{$address.second_street_line}" name="address[second_street_line]">
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="city" class="control-label">City <span class="required">*</span></label>
                            <div class="controls form-group">
                                <div class="col-xs-12 col-sm-6"><input id="city" class="form-control" required="required" type="text" value="{$address.municipality_major}" name="address[municipality_major]"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="state" class="control-label">State <span class="required">*</span></label>
                            <div class="controls form-group">
                                <select id="state" data-placeholder="Select state"
                                        required="required" class="col-xs-12 col-sm-6 form-control" value="{$address.district}" name="address[district]">
                                    <option value="AL">Alabama</option>
                                    <option value="AK">Alaska</option>
                                    <option value="AZ">Arizona</option>
                                    <option value="AR">Arkansas</option>
                                    <option value="CA">California</option>
                                    <option value="CO">Colorado</option>
                                    <option value="CT">Connecticut</option>
                                    <option value="DE">Delaware</option>
                                    <option value="DC">District Of Columbia</option>
                                    <option value="FL">Florida</option>
                                    <option value="GA">Georgia</option>
                                    <option value="HI">Hawaii</option>
                                    <option value="ID">Idaho</option>
                                    <option value="IL">Illinois</option>
                                    <option value="IN">Indiana</option>
                                    <option value="IA">Iowa</option>
                                    <option value="KS">Kansas</option>
                                    <option value="KY">Kentucky</option>
                                    <option value="LA">Louisiana</option>
                                    <option value="ME">Maine</option>
                                    <option value="MD">Maryland</option>
                                    <option value="MA">Massachusetts</option>
                                    <option value="MI">Michigan</option>
                                    <option value="MN">Minnesota</option>
                                    <option value="MS">Mississippi</option>
                                    <option value="MO">Missouri</option>
                                    <option value="MT">Montana</option>
                                    <option value="NE">Nebraska</option>
                                    <option value="NV">Nevada</option>
                                    <option value="NH">New Hampshire</option>
                                    <option value="NJ">New Jersey</option>
                                    <option value="NM">New Mexico</option>
                                    <option value="NY">New York</option>
                                    <option value="NC">North Carolina</option>
                                    <option value="ND">North Dakota</option>
                                    <option value="OH">Ohio</option>
                                    <option value="OK">Oklahoma</option>
                                    <option value="OR">Oregon</option>
                                    <option value="PA">Pennsylvania</option>
                                    <option value="RI">Rhode Island</option>
                                    <option value="SC">South Carolina</option>
                                    <option value="SD">South Dakota</option>
                                    <option value="TN">Tennessee</option>
                                    <option value="TX">Texas</option>
                                    <option value="UT">Utah</option>
                                    <option value="VT">Vermont</option>
                                    <option value="VA">Virginia</option>
                                    <option value="WA">Washington</option>
                                    <option value="WV">West Virginia</option>
                                    <option value="WI">Wisconsin</option>
                                    <option value="WY">Wyoming</option>
                                </select>
                                <script type="text/javascript">
                               		var s = $('#state option'), o;
	                                for (var i = s.length - 1; i >= 0; i--) {
	                                	o = $(s[i]);
	                                	if(o.val() == "{$address.district}")
	                                		o.attr({ selected : true });
	                                }; 
                                </script>
                            </div>
                        </div>
                         <div class="control-group">
                            <label for="city" class="control-label">Postal <span class="required">*</span></label>
                            <div class="controls form-group">
                                <div class="col-xs-12 col-sm-6"><input id="city" class="form-control" required="required" type="text" value="{$address.postal}" name="address[postal]"></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="country" class="control-label">Country <span class="required">*</span></label>
                            <div class="controls form-group">
                                <select id="country" required="required"
                                        data-placeholder="Select country" class="col-xs-12 col-sm-6 form-control" value="{$address.country}" name="address[country]">
                                     
                                    <option selected="true" value="United States">United States</option>
                                    <option value="United Kingdom">United Kingdom</option>
                                    <option value="Afghanistan">Afghanistan</option>
                                    <option value="Albania">Albania</option>
                                    <option value="Algeria">Algeria</option>
                                    <option value="American Samoa">American Samoa</option>
                                    <option value="Andorra">Andorra</option>
                                    <option value="Angola">Angola</option>
                                    <option value="Anguilla">Anguilla</option>
                                    <option value="Antarctica">Antarctica</option>
                                    <option value="Antigua and Barbuda">Antigua and Barbuda</option>
                                    <option value="Argentina">Argentina</option>
                                    <option value="Armenia">Armenia</option>
                                    <option value="Aruba">Aruba</option>
                                    <option value="Australia">Australia</option>
                                    <option value="Austria">Austria</option>
                                    <option value="Azerbaijan">Azerbaijan</option>
                                    <option value="Bahamas">Bahamas</option>
                                    <option value="Bahrain">Bahrain</option>
                                    <option value="Bangladesh">Bangladesh</option>
                                    <option value="Barbados">Barbados</option>
                                    <option value="Belarus">Belarus</option>
                                    <option value="Belgium">Belgium</option>
                                    <option value="Belize">Belize</option>
                                    <option value="Benin">Benin</option>
                                    <option value="Bermuda">Bermuda</option>
                                    <option value="Bhutan">Bhutan</option>
                                    <option value="Bolivia">Bolivia</option>
                                    <option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
                                    <option value="Botswana">Botswana</option>
                                    <option value="Bouvet Island">Bouvet Island</option>
                                    <option value="Brazil">Brazil</option>
                                    <option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
                                    <option value="Brunei Darussalam">Brunei Darussalam</option>
                                    <option value="Bulgaria">Bulgaria</option>
                                    <option value="Burkina Faso">Burkina Faso</option>
                                    <option value="Burundi">Burundi</option>
                                    <option value="Cambodia">Cambodia</option>
                                    <option value="Cameroon">Cameroon</option>
                                    <option value="Canada">Canada</option>
                                    <option value="Cape Verde">Cape Verde</option>
                                    <option value="Cayman Islands">Cayman Islands</option>
                                    <option value="Central African Republic">Central African Republic</option>
                                    <option value="Chad">Chad</option>
                                    <option value="Chile">Chile</option>
                                    <option value="China">China</option>
                                    <option value="Christmas Island">Christmas Island</option>
                                    <option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
                                    <option value="Colombia">Colombia</option>
                                    <option value="Comoros">Comoros</option>
                                    <option value="Congo">Congo</option>
                                    <option value="Congo, The Democratic Republic of The">Congo, The Democratic Republic of The</option>
                                    <option value="Cook Islands">Cook Islands</option>
                                    <option value="Costa Rica">Costa Rica</option>
                                    <option value="Cote D'ivoire">Cote D'ivoire</option>
                                    <option value="Croatia">Croatia</option>
                                    <option value="Cuba">Cuba</option>
                                    <option value="Cyprus">Cyprus</option>
                                    <option value="Czech Republic">Czech Republic</option>
                                    <option value="Denmark">Denmark</option>
                                    <option value="Djibouti">Djibouti</option>
                                    <option value="Dominica">Dominica</option>
                                    <option value="Dominican Republic">Dominican Republic</option>
                                    <option value="Ecuador">Ecuador</option>
                                    <option value="Egypt">Egypt</option>
                                    <option value="El Salvador">El Salvador</option>
                                    <option value="Equatorial Guinea">Equatorial Guinea</option>
                                    <option value="Eritrea">Eritrea</option>
                                    <option value="Estonia">Estonia</option>
                                    <option value="Ethiopia">Ethiopia</option>
                                    <option value="Falkland Islands (Malvinas)">Falkland Islands (Malvinas)</option>
                                    <option value="Faroe Islands">Faroe Islands</option>
                                    <option value="Fiji">Fiji</option>
                                    <option value="Finland">Finland</option>
                                    <option value="France">France</option>
                                    <option value="French Guiana">French Guiana</option>
                                    <option value="French Polynesia">French Polynesia</option>
                                    <option value="French Southern Territories">French Southern Territories</option>
                                    <option value="Gabon">Gabon</option>
                                    <option value="Gambia">Gambia</option>
                                    <option value="Georgia">Georgia</option>
                                    <option value="Germany">Germany</option>
                                    <option value="Ghana">Ghana</option>
                                    <option value="Gibraltar">Gibraltar</option>
                                    <option value="Greece">Greece</option>
                                    <option value="Greenland">Greenland</option>
                                    <option value="Grenada">Grenada</option>
                                    <option value="Guadeloupe">Guadeloupe</option>
                                    <option value="Guam">Guam</option>
                                    <option value="Guatemala">Guatemala</option>
                                    <option value="Guinea">Guinea</option>
                                    <option value="Guinea-bissau">Guinea-bissau</option>
                                    <option value="Guyana">Guyana</option>
                                    <option value="Haiti">Haiti</option>
                                    <option value="Heard Island and Mcdonald Islands">Heard Island and Mcdonald Islands</option>
                                    <option value="Holy See (Vatican City State)">Holy See (Vatican City State)</option>
                                    <option value="Honduras">Honduras</option>
                                    <option value="Hong Kong">Hong Kong</option>
                                    <option value="Hungary">Hungary</option>
                                    <option value="Iceland">Iceland</option>
                                    <option value="India">India</option>
                                    <option value="Indonesia">Indonesia</option>
                                    <option value="Iran, Islamic Republic of">Iran, Islamic Republic of</option>
                                    <option value="Iraq">Iraq</option>
                                    <option value="Ireland">Ireland</option>
                                    <option value="Israel">Israel</option>
                                    <option value="Italy">Italy</option>
                                    <option value="Jamaica">Jamaica</option>
                                    <option value="Japan">Japan</option>
                                    <option value="Jordan">Jordan</option>
                                    <option value="Kazakhstan">Kazakhstan</option>
                                    <option value="Kenya">Kenya</option>
                                    <option value="Kiribati">Kiribati</option>
                                    <option value="Korea, Democratic People's Republic of">Korea, Democratic People's Republic of</option>
                                    <option value="Korea, Republic of">Korea, Republic of</option>
                                    <option value="Kuwait">Kuwait</option>
                                    <option value="Kyrgyzstan">Kyrgyzstan</option>
                                    <option value="Lao People's Democratic Republic">Lao People's Democratic Republic</option>
                                    <option value="Latvia">Latvia</option>
                                    <option value="Lebanon">Lebanon</option>
                                    <option value="Lesotho">Lesotho</option>
                                    <option value="Liberia">Liberia</option>
                                    <option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
                                    <option value="Liechtenstein">Liechtenstein</option>
                                    <option value="Lithuania">Lithuania</option>
                                    <option value="Luxembourg">Luxembourg</option>
                                    <option value="Macao">Macao</option>
                                    <option value="Macedonia, The Former Yugoslav Republic of">Macedonia, The Former Yugoslav Republic of</option>
                                    <option value="Madagascar">Madagascar</option>
                                    <option value="Malawi">Malawi</option>
                                    <option value="Malaysia">Malaysia</option>
                                    <option value="Maldives">Maldives</option>
                                    <option value="Mali">Mali</option>
                                    <option value="Malta">Malta</option>
                                    <option value="Marshall Islands">Marshall Islands</option>
                                    <option value="Martinique">Martinique</option>
                                    <option value="Mauritania">Mauritania</option>
                                    <option value="Mauritius">Mauritius</option>
                                    <option value="Mayotte">Mayotte</option>
                                    <option value="Mexico">Mexico</option>
                                    <option value="Micronesia, Federated States of">Micronesia, Federated States of</option>
                                    <option value="Moldova, Republic of">Moldova, Republic of</option>
                                    <option value="Monaco">Monaco</option>
                                    <option value="Mongolia">Mongolia</option>
                                    <option value="Montserrat">Montserrat</option>
                                    <option value="Morocco">Morocco</option>
                                    <option value="Mozambique">Mozambique</option>
                                    <option value="Myanmar">Myanmar</option>
                                    <option value="Namibia">Namibia</option>
                                    <option value="Nauru">Nauru</option>
                                    <option value="Nepal">Nepal</option>
                                    <option value="Netherlands">Netherlands</option>
                                    <option value="Netherlands Antilles">Netherlands Antilles</option>
                                    <option value="New Caledonia">New Caledonia</option>
                                    <option value="New Zealand">New Zealand</option>
                                    <option value="Nicaragua">Nicaragua</option>
                                    <option value="Niger">Niger</option>
                                    <option value="Nigeria">Nigeria</option>
                                    <option value="Niue">Niue</option>
                                    <option value="Norfolk Island">Norfolk Island</option>
                                    <option value="Northern Mariana Islands">Northern Mariana Islands</option>
                                    <option value="Norway">Norway</option>
                                    <option value="Oman">Oman</option>
                                    <option value="Pakistan">Pakistan</option>
                                    <option value="Palau">Palau</option>
                                    <option value="Palestinian Territory, Occupied">Palestinian Territory, Occupied</option>
                                    <option value="Panama">Panama</option>
                                    <option value="Papua New Guinea">Papua New Guinea</option>
                                    <option value="Paraguay">Paraguay</option>
                                    <option value="Peru">Peru</option>
                                    <option value="Philippines">Philippines</option>
                                    <option value="Pitcairn">Pitcairn</option>
                                    <option value="Poland">Poland</option>
                                    <option value="Portugal">Portugal</option>
                                    <option value="Puerto Rico">Puerto Rico</option>
                                    <option value="Qatar">Qatar</option>
                                    <option value="Reunion">Reunion</option>
                                    <option value="Romania">Romania</option>
                                    <option value="Russian Federation">Russian Federation</option>
                                    <option value="Rwanda">Rwanda</option>
                                    <option value="Saint Helena">Saint Helena</option>
                                    <option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
                                    <option value="Saint Lucia">Saint Lucia</option>
                                    <option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
                                    <option value="Saint Vincent and The Grenadines">Saint Vincent and The Grenadines</option>
                                    <option value="Samoa">Samoa</option>
                                    <option value="San Marino">San Marino</option>
                                    <option value="Sao Tome and Principe">Sao Tome and Principe</option>
                                    <option value="Saudi Arabia">Saudi Arabia</option>
                                    <option value="Senegal">Senegal</option>
                                    <option value="Serbia and Montenegro">Serbia and Montenegro</option>
                                    <option value="Seychelles">Seychelles</option>
                                    <option value="Sierra Leone">Sierra Leone</option>
                                    <option value="Singapore">Singapore</option>
                                    <option value="Slovakia">Slovakia</option>
                                    <option value="Slovenia">Slovenia</option>
                                    <option value="Solomon Islands">Solomon Islands</option>
                                    <option value="Somalia">Somalia</option>
                                    <option value="South Africa">South Africa</option>
                                    <option value="South Georgia and The South Sandwich Islands">South Georgia and The South Sandwich Islands</option>
                                    <option value="Spain">Spain</option>
                                    <option value="Sri Lanka">Sri Lanka</option>
                                    <option value="Sudan">Sudan</option>
                                    <option value="Suriname">Suriname</option>
                                    <option value="Svalbard and Jan Mayen">Svalbard and Jan Mayen</option>
                                    <option value="Swaziland">Swaziland</option>
                                    <option value="Sweden">Sweden</option>
                                    <option value="Switzerland">Switzerland</option>
                                    <option value="Syrian Arab Republic">Syrian Arab Republic</option>
                                    <option value="Taiwan, Province of China">Taiwan, Province of China</option>
                                    <option value="Tajikistan">Tajikistan</option>
                                    <option value="Tanzania, United Republic of">Tanzania, United Republic of</option>
                                    <option value="Thailand">Thailand</option>
                                    <option value="Timor-leste">Timor-leste</option>
                                    <option value="Togo">Togo</option>
                                    <option value="Tokelau">Tokelau</option>
                                    <option value="Tonga">Tonga</option>
                                    <option value="Trinidad and Tobago">Trinidad and Tobago</option>
                                    <option value="Tunisia">Tunisia</option>
                                    <option value="Turkey">Turkey</option>
                                    <option value="Turkmenistan">Turkmenistan</option>
                                    <option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
                                    <option value="Tuvalu">Tuvalu</option>
                                    <option value="Uganda">Uganda</option>
                                    <option value="Ukraine">Ukraine</option>
                                    <option value="United Arab Emirates">United Arab Emirates</option>
                                    <option value="United Kingdom">United Kingdom</option>
                                    <option value="United States">United States</option>
                                    <option value="United States Minor Outlying Islands">United States Minor Outlying Islands</option>
                                    <option value="Uruguay">Uruguay</option>
                                    <option value="Uzbekistan">Uzbekistan</option>
                                    <option value="Vanuatu">Vanuatu</option>
                                    <option value="Venezuela">Venezuela</option>
                                    <option value="Viet Nam">Viet Nam</option>
                                    <option value="Virgin Islands, British">Virgin Islands, British</option>
                                    <option value="Virgin Islands, U.S.">Virgin Islands, U.S.</option>
                                    <option value="Wallis and Futuna">Wallis and Futuna</option>
                                    <option value="Western Sahara">Western Sahara</option>
                                    <option value="Yemen">Yemen</option>
                                    <option value="Zambia">Zambia</option>
                                    <option value="Zimbabwe">Zimbabwe</option>
                                </select>
                            </div>
                        </div>
                       <!--  <div class="control-group text-align-center">
		                    <label class="control-label">Payment Options:</label>
		                    <div class="controls form-group">
		                        <div class="btn-group" data-toggle="buttons">
		                            <label class="btn btn-info btn-sm disabled" data-toggle-class="btn-success" data-toggle-passive-class="btn-info">
		                                <input type="radio">  <i class="fa fa-money"></i> Paypal
		                            </label>
		                            <label class="btn btn-success active btn-sm" data-toggle-class="btn-success" data-toggle-passive-class="btn-info">
		                                <input type="radio"> Credit Card <i class="fa fa-credit-card"></i>
		                            </label>
		                            <label class="btn btn-primary btn-sm active" data-toggle-class="btn-primary" data-toggle-passive-class="btn-info">
		                                <input type="radio"> Right
		                            </label>
		                        </div>
		                    </div>
		                    
		                </div> -->

                   
					</div>
				

					<button class="btn btn-bottom btn-lg btn-block btn-success" type="submit">
						
						 <h2>View Order <i class="fa fa-check"></i></h2>
						 
					</button>
						
				</form>
			</div>
		{/if}

		
		{if $data.items|count == 0}
			<div class="empty-cart">
				<p class="lead">Your don't currently have any items in your cart.</p>
				<p>Please <a href="index.html">return to the shop</a>.</p>
			</div>
		{else}
			{foreach $data.items as $key => $item} 
				<div class="product medium cat-{$item.hash}" id="product-{$item.sku}">
					<form class="form-inline"  action="/{$Xtra}/checkout/"  onsubmit="return false;"  method="POST"> 
					<div class="media">
						
						<a href="/{$Xtra}/item/{$item.sku}" title="">
						<div id="{$key}" class="carousel slide">
		                    <ol class="carousel-indicators outer">  
		                        {foreach $data.pics[$item.sku] as $p => $pic}
		                            {if $key} 
		                        <li data-target="#{$key}" {if $p==0}class="active"{/if} data-slide-to="{$p}"></li>    
		                            {/if}
		                        {/foreach} 
		                    </ol>
		                    <div class="carousel-inner text-align-center">
		                        <!-- {counter start=-1} -->
		                        {foreach $data.pics[$item.sku] as $p => $pic}
		                        	{$pic="{$thumb}h=437&src=/{$toBackDoor}/_cfg/{$HTTP_HOST}/{$Xtra}/shelves/{$item.sku}/{$pic}"}
		                            <div class="item {if $p == 0}active{/if}" style="background-image:url('{$pic}'); background-repeat: no-repeat; background-size: cover; background-position: center center; 
		                            height:{if $rand =='large'}437px{else}190px{/if}"> 
		                            	<img src="{$pic}" class="hidden" />  
			                        </div> 
		                        {/foreach} 
		                    </div>



		                    {if $data.pics[$item.sku]|count > 1}
		                    	{$icon = "fa fa-angle"} 

			                    <a class="left carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="prev"> 
			                        <i class="{$icon}-left"></i> 
			                    </a>
			                    <a class="right carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="next">
			                        <i class="{$icon}-right"></i>
			                    </a>
		                    {/if} 
		                </div>


						
						</a>

						<span class="plabel" >
							<p class="name panel">{$item.name}</p>  
							<h2  class="total price panel">{$item.price}</h2>
						</span>	 

						<!-- <h1 class="price panel"><span class="cur">$</span></h1> -->
						<!-- <span class="plabel">just in</span>				 -->
						</div>

						<div class="details">
							 <a href="/{$Xtra}/{$method}/remove/{$item.sku}"  class="details-expand" data-target="details-{$item.sku}"><b><i class="fa fa-trash-o"></i> </b></a>
						</div>
<!-- 
						<div class="details-extra" id="details-{$item.sku}"> 
							<a class="btn btn-bottom btn-atc btn-primary"  href="/{$Xtra}/{$method}/remove/{$item.sku}" >
								Remove <i class="fa fa-trash-o"></i> 
							</a>			

						</div> -->

						<!-- {counter}  -->
					</form> 
				</div>
			{/foreach}

            <script type="text/javascript">
                window.checkout = {
                    requestSent : false,
                    order : function  (e) {
                        if(!window.checkout.requestSent)
                            $.ajax({
                                type     : 'POST',
                                url      : '/{$Xtra}/{$method}/order/.json',
                                data     : $('#shipping-address').serializeObject(),
                                dataType : 'json',
                                success : function  (data) {
                                    DATA = data;    
                                    if(data.success){
                                        window.location.href = '/{$Xtra}/order/'+data.success;
                                    } else {
                                        alert(data.error);
                                    }
                                }
                            });
                        e.preventDefault();
                    }
                };
            </script>
		      
			<script type="text/javascript">

			/**
			 * jQuery serializeObject
			 * @copyright 2014, macek <paulmacek@gmail.com>
			 * @link https://github.com/macek/jquery-serialize-object
			 * @license BSD
			 * @version 2.3.0
			 */
			 {literal}
			!function(e,i){if("function"==typeof define&&define.amd)define(["jquery","exports"],function(r,t){i(e,t,r)});else if("undefined"!=typeof exports){var r=require("jquery");i(e,exports,r)}else e.FormSerializer=i(e,{},e.jQuery||e.Zepto||e.ender||e.$)}(this,function(e,i,r){function t(e){function i(e,i,r){return e[i]=r,e}function r(e,r){for(var a,s=e.match(n.key);void 0!==(a=s.pop());)if(n.push.test(a)){var o=t(e.replace(/\[\]$/,""));r=i([],o,r)}else n.fixed.test(a)?r=i([],a,r):n.named.test(a)&&(r=i({},a,r));return r}function t(e){return void 0===d[e]&&(d[e]=0),d[e]++}function a(i){if(!n.validate.test(i.name))return this;var t=r(i.name,i.value);return u=e.extend(!0,u,t),this}function s(i){if(!e.isArray(i))throw new Error("formSerializer.addPairs expects an Array");for(var r=0,t=i.length;t>r;r++)this.addPair(i[r]);return this}function o(){return u}function f(){return JSON.stringify(o())}var u={},d={};this.addPair=a,this.addPairs=s,this.serialize=o,this.serializeJSON=f}var n={validate:/^[a-z][a-z0-9_]*(?:\[(?:\d*|[a-z0-9_]+)\])*$/i,key:/[a-z0-9_]+|(?=\[\])/gi,push:/^$/,fixed:/^\d+$/,named:/^[a-z0-9_]+$/i};return t.patterns=n,t.serializeObject=function(){return this.length>1?new Error("jquery-serialize-object can only serialize one form at a time"):new t(r).addPairs(this.serializeArray()).serialize()},t.serializeJSON=function(){return this.length>1?new Error("jquery-serialize-object can only serialize one form at a time"):new t(r).addPairs(this.serializeArray()).serializeJSON()},"undefined"!=typeof r.fn&&(r.fn.serializeObject=t.serializeObject,r.fn.serializeJSON=t.serializeJSON),i.FormSerializer=t,t});
			{/literal}
			</script>
		{/if}
        <div class="product col-md-5 static  pull-right no-padding">
            <div class="text-align-center">
                <!-- <h1><i class="fa fa-shopping-cart"></i> Shopping Cart</h1>
                <p class="lead">
                    {$shop_intro}
                </p>  -->
                <table class="table table-striped col-md-12 no-margin">
                    <tbody>
                        {foreach $data.items as $key => $item}
                        <tr>
                            
                            <td class="price col-md-2" align="right">
                                <h5><a href="#">{$item.price}</a></h5>
                            </td>
                            <td class="name col-md-8" align="left">
                                <h5><a href="item/{$item.sku}">{$item.name}</a></h5>
                            </td>
                            <td class="trash col-md-2" align="center">
                                <h4><a href="/{$Xtra}/{$method}/remove/{$item.sku}"><i class="fa fa-trash-o"></i></a></h4>
                            </td> 
                            <!-- <td class="size"><span class="size-small">M</span><span class="size-large">Medium</span></td> -->
                            <!-- <td class="stock instock"><span class="stock-small"></span><span class="stock-large">In stock</span></td> -->
                            <!-- <td class="quantity-cell">
                                <a href="" class="quantity minus">-</a>
                                <span class="order-quantity" data-sub="20">0</span>
                                <a href="" class="quantity plus">+</a>                                  
                            </td> -->
                            <!-- <td class="sub-total"><span class="currency">$</span><span class="total">{$item.price|substr:1}</span></td> -->
                            <!-- <td><a href="" class="cart-remove pull-right"><span class="remove-small">x</span><span class="remove-large">remove</span></a></td> -->
                        </tr> 
                        {/foreach} 
                    </tbody>
                </table>        
            </div>
            {if $data.items|count == 0}
                <a href="javascript: window.history.back()" class="btn btn-bottom btn-lg btn-block btn-info customButton">
                    
                    <i class="fa fa-backward"></i> Cart Empty 
                     
                </a>
            {else} 
                <button class="btn btn-bottom btn-lg btn-block btn-primary active customButton">
                    
                    <h2>Total:  ${$data.total}  </h2>
                     
                </button> 
            {/if}
        </div>
	</div>