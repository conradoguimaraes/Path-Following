function offset = gerarOffset(peso)
    offset = sign(randn())*randn();
    offset = offset; %ajustar o valor
    
    %Aplicar um peso conforme seja positivo ou negativo
    %Ex: se for positivo, multiplica por 1.5
    %se for negativo multiplica por 0.5
    if (offset > 0)
        offset = offset * (1.5 + peso);
    elseif (offset < 0)
        offset = offset * (2 + peso);
    end
end